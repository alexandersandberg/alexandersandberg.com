import Foundation
import Ink
import SwiftHtml

let fileManager = FileManager.default
let documentRenderer = DocumentRenderer(minify: true)

let modifier = Modifier(target: .links) { html, markdown in
	guard markdown.contains("https://") else { return html }

	return html.replacingOccurrences(of: "<a", with: "<a target='_blank'") + ExternalLinkArrow.htmlString
}
let markdownParser = MarkdownParser(modifiers: [modifier])

let rootPath = fileManager.currentDirectoryPath
let assetsDirectory = URL(fileURLWithPath: "\(rootPath)/Assets", isDirectory: true)
let contentDirectory = URL(fileURLWithPath: "\(rootPath)/Content", isDirectory: true)
let outputDirectory = URL(fileURLWithPath: "\(rootPath)/.output", isDirectory: true)

enum Site {
	static let url = "https://alexandersandberg.com"
	static let author = "Alexander Sandberg"
	static let bio = "<em>Software tinkerer</em>. Creating, experimenting, learning. Keeping it simple. <span class='nowrap'>Building carefully</span> crafted Swift and SwiftUI apps."
	static let email = "hi@alexandersandberg.com"
	static let cdn = "https://cdn.alexandersandberg.com"
	static let cssFileName = "styles.css"
}

var assetsHashes: [String : String] = [:]

let documentPages = [
	Page(
		path: "",
		contentHtmlString: documentRenderer.render(homeDocument)
	),
	Page(
		path: "about",
		layout: .page(title: "About me"),
		contentHtmlString: documentRenderer.render(aboutDocument)
	),
	Page(
		path: "articles",
		layout: .list(title: "Articles"),
		contentHtmlString: documentRenderer.render(articleListDocument)
	),
	Page(
		path: "apps",
		layout: .page(title: "Apps"),
		contentHtmlString: documentRenderer.render(appsDocument)
	),
	Page(
		path: "balance",
		layout: .balance(title: "Balance"),
		contentHtmlString: documentRenderer.render(balanceDocument)
	)
]
let indieApps = [
	Project(
		title: "Balance",
		href: "/balance/",
		description: "Time-tracking app with a focus on work-life balance.",
		highlightedText: "My latest indie app!"
	),
	Project(
		title: "Tiny Softbox",
		href: "https://apps.apple.com/app/id1599476381",
		description: "Simple softbox for video calls, photography, reading, etc."
	),
	Project(
		title: "Tiny Weather",
		href: "https://apps.apple.com/app/id1522059185",
		description: "Minimal weather app that protects your privacy."
	),
]
var pages: [Page] = []
var articles: [Page] = []

@main
struct Main {
	static func main() async throws {
		prepareOutputFolder()
		await prepareAssets()
		buildLifeLessons()
		await buildContent()
		buildPages()
		buildFeed()
	}
}

func prepareOutputFolder() {
	do {
		if fileManager.fileExists(atPath: outputDirectory.path) {
			try fileManager.removeItem(at: outputDirectory)
		}
		try fileManager.createDirectory(at: outputDirectory, withIntermediateDirectories: true)
	} catch {
		fatalError("\(#function): \(error)")
	}
}

func prepareAssets() async {
	do {
		let contentFiles = fileManager.walkDirectory(at: assetsDirectory)
		for await contentFile in contentFiles {
			try fileManager.copyItem(at: contentFile, to: outputDirectory.appending(path: contentFile.lastPathComponent))

			if contentFile.pathExtension == "css" {
				let cssString = try String(contentsOf: contentFile)
				assetsHashes[contentFile.lastPathComponent] = cssString.md5Hash
			}
		}
	} catch {
		fatalError("\(#function): \(error)")
	}
}

func buildLifeLessons() {
	do {
		let lessons = JSONDecoder().decode([LifeLesson].self, from: "life_lessons.json")
		let categories = lessons.reduce(into: [:]) { $0[$1.category, default: []].append($1) }

		let lifeLessonListPage = Page(
			path: "life-lessons",
			layout: .list(title: "Life lessons"),
			contentHtmlString: documentRenderer.render(lifeLessonListDocument(categories: categories))
		)
		pages.append(lifeLessonListPage)

		for (category, lessons) in categories {
			let contentHtmlString = lessons.map { lesson in
				let lessonDocument = Document(.html) {
					LifeLessonItem(lesson: lesson)
				}
				let html = documentRenderer.render(lessonDocument)
				let markdown = markdownParser.parse(lesson.markdown)
				return html.replacing("<\(Content().name)>", with: markdown.html)
			}.joined()
			let page = Page(
				path: category.path,
				layout: .lifeLessonCategory(title: category.title, lessonCount: lessons.count),
				contentHtmlString: contentHtmlString
			)
			try page.htmlString.writeToOutputDirectory(path: page.path, prettyURL: page.prettyURL)

			pages.append(page)
		}
	} catch {
		fatalError("\(#function): \(error)")
	}
}

func buildContent() async {
	do {
		let contentFiles = fileManager.walkDirectory(at: contentDirectory)
		for await contentFile in contentFiles {
			guard contentFile.pathExtension == "md" else {
				print("\(contentDirectory) only supports .md files; skipping \(contentFile.withoutRootPath)")
				continue
			}

			let page = try Page(from: contentFile)
			try page.htmlString.writeToOutputDirectory(path: page.path, prettyURL: page.prettyURL)

			pages.append(page)

			if case .article = page.layout {
				articles.append(page)
			}
		}
	} catch {
		fatalError("\(#function): \(error)")
	}
}

func buildPages() {
	do {
		pages.append(contentsOf: documentPages)

		for page in pages {
			try page.htmlString.writeToOutputDirectory(path: page.path, prettyURL: page.prettyURL)
		}
	} catch {
		fatalError("\(#function): \(error)")
	}
}

func buildFeed() {
	do {
		let rssString = documentRenderer.render(rssDocument)
		try rssString.writeToOutputDirectory(path: "feed.rss", prettyURL: false)
	} catch {
		fatalError("\(#function): \(error)")
	}
}
