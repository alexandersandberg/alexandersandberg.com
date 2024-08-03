import Foundation
import Ink
import SwiftHtml

let fileManager = FileManager.default
let documentRenderer = DocumentRenderer(minify: true)

let markdownParser = MarkdownParser()

let rootPath = fileManager.currentDirectoryPath
let assetsDirectory = URL(fileURLWithPath: "\(rootPath)/Assets", isDirectory: true)
let contentDirectory = URL(fileURLWithPath: "\(rootPath)/Content", isDirectory: true)
let outputDirectory = URL(fileURLWithPath: "\(rootPath)/.output", isDirectory: true)

enum Site {
	static let url = "https://alexandersandberg.com"
	static let author = "Alexander Sandberg"
	static let bio = "<em>Software tinkerer</em>. Creating, exploring, learning. Keeping it simple. <span class='nowrap'>Building carefully</span> crafted Swift and SwiftUI apps."
	static let email = "hi@alexandersandberg.com"
	static let cdn = "https://cdn.alexandersandberg.com"
	static let cssFileName = "styles.css"
}

var assetsHashes: [String : String] = [:]

let documentPages = [
	Page(
		path: "",
		contentHtmlString: documentRenderer.render(homeDocument, withLinkSuffixes: true)
	),
	Page(
		path: "about",
		layout: .page(title: "About"),
		contentHtmlString: documentRenderer.render(aboutDocument, withLinkSuffixes: true)
	),
	Page(
		path: "articles",
		layout: .list(title: "Articles"),
		contentHtmlString: documentRenderer.render(articleListDocument, withLinkSuffixes: true)
	),
	Page(
		path: "apps",
		layout: .page(title: "Apps"),
		contentHtmlString: documentRenderer.render(appsDocument, withLinkSuffixes: true)
	),
	Page(
		path: "balance",
		contentHtmlString: documentRenderer.render(balanceDocument, withLinkSuffixes: true)
	)
]
let indieApps = [
	LinkedResource(
		title: "Balance",
		href: "/balance/",
		description: "A time tracking app that helps you balance work and life.",
		highlightedText: "My latest indie app!"
	),
	LinkedResource(
		title: "Tiny Softbox",
		href: "https://apps.apple.com/app/id1599476381",
		description: "Simple softbox for video calls, photography, reading, etc."
	),
	LinkedResource(
		title: "Tiny Weather",
		href: "https://apps.apple.com/app/id1522059185",
		description: "Minimal weather app that protects your privacy."
	),
]
var pages: [Page] = []
var articles: [Page] = []
var notes: [Note] = []

@main
struct Main {
	static func main() async throws {
		prepareOutputFolder()
		await prepareAssets()
		buildNotes()
		buildLifeLessons()
		await buildContent()
		makePages()
		makeFeed()
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
			try fileManager.copyItem(at: contentFile, to: outputDirectory.appendingPathComponent(contentFile.lastPathComponent))

			if contentFile.pathExtension == "css" {
				let cssString = try String(contentsOf: contentFile)
				assetsHashes[contentFile.lastPathComponent] = cssString.md5Hash
			}
		}
	} catch {
		fatalError("\(#function): \(error)")
	}
}

func buildNotes() {
	var noteItems = JSONDecoder().decode([Note].self, from: "notes.json")

	noteItems = noteItems.map {
		var note = $0
		note.contentHtmlString = markdownParser.parse(note.markdown).html
		return note
	}
	.sorted(by: >)

	notes = noteItems

	let noteListPage = Page(
		path: "notes",
		layout: .list(title: "Notes"),
		updatedAt: noteItems.first?.publishedAt,
		contentHtmlString: documentRenderer.render(noteListDocument(notes: noteItems), withLinkSuffixes: true)
	)
	pages.append(noteListPage)
}

func buildLifeLessons() {
	let lessons = JSONDecoder().decode([LifeLesson].self, from: "life_lessons.json")
	let categories = lessons.reduce(into: [:]) { $0[$1.category, default: []].append($1) }

	let lifeLessonListPage = Page(
		path: "life-lessons",
		layout: .list(title: "Life lessons"),
		contentHtmlString: documentRenderer.render(lifeLessonListDocument(categories: categories), withLinkSuffixes: true)
	)
	pages.append(lifeLessonListPage)

	for (category, lessons) in categories {
		let contentHtmlString = lessons.map { lesson in
			let markdown = markdownParser.parse(lesson.markdown)
			let lessonDocument = Document(.html) {
				LifeLessonItem(lesson: lesson, contentHtmlString: markdown.html)
			}
			return documentRenderer.render(lessonDocument, withLinkSuffixes: true)
		}.joined()
		let page = Page(
			path: category.path,
			layout: .lifeLessonCategory(title: category.title, lessonCount: lessons.count),
			contentHtmlString: contentHtmlString
		)

		pages.append(page)
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

			pages.append(page)

			if case .article = page.layout {
				articles.append(page)
			}
		}
	} catch {
		fatalError("\(#function): \(error)")
	}
}

func makePages() {
	do {
		pages.append(contentsOf: documentPages)

		for page in pages {
			try page.htmlString.writeToOutputDirectory(path: page.path, prettyURL: page.prettyURL)
		}
	} catch {
		fatalError("\(#function): \(error)")
	}
}

func makeFeed() {
	do {
		let rssString = documentRenderer.render(rssDocument)
		try rssString.writeToOutputDirectory(path: "feed.rss", prettyURL: false)
	} catch {
		fatalError("\(#function): \(error)")
	}
}
