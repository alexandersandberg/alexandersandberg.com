import Foundation
import Ink
import SwiftHtml

let fileManager = FileManager.default
let markdownParser = MarkdownParser()
let documentRenderer = DocumentRenderer(minify: true)

let rootPath = fileManager.currentDirectoryPath
let assetsDirectory = URL(fileURLWithPath: "\(rootPath)/Assets", isDirectory: true)
let contentDirectory = URL(fileURLWithPath: "\(rootPath)/Content", isDirectory: true)
let outputDirectory = URL(fileURLWithPath: "\(rootPath)/.output", isDirectory: true)

struct Site {
	static let author = "Alexander Sandberg"
	static let bio = "<em>Software tinkerer</em>. Creating, experimenting, learning. Keeping it simple. <span class='nowrap'>Building carefully</span> crafted Swift and SwiftUI apps."
	static let email = "hi@alexandersandberg.com"
	static let cdn = "https://cdn.alexandersandberg.com/"
}

let pages = [
	Page(
		path: "",
		htmlContentString: documentRenderer.render(homeDocument)
	),
	Page(
		path: "about",
		layout: .page(title: "About me"),
		htmlContentString: documentRenderer.render(aboutDocument)
	),
	Page(
		path: "articles",
		layout: .list(title: "Articles"),
		htmlContentString: documentRenderer.render(articlesDocument)
	),
	Page(
		path: "apps",
		layout: .page(title: "Apps"),
		htmlContentString: documentRenderer.render(appsDocument)
	),
	Page(
		path: "life-lessons",
		layout: .list(title: "Life lessons"),
		htmlContentString: documentRenderer.render(lifeLessonsDocument)
	)
]
var contentPages: [ContentPage] = []
let indieApps = [
	Project(
		title: "Balance",
		href: "/balance",
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
let lifeLessons = JSONDecoder().decode([LifeLesson].self, from: "life_lessons.json")

@main
struct Main {
	static func main() async throws {
		prepareOutputFolder()
		copyAssets()
		await buildContent()
		buildPages()
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

func copyAssets() {
	do {
		try fileManager.copyItem(at: assetsDirectory, to: outputDirectory.appending(path: assetsDirectory.lastPathComponent.lowercased()))
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

			let page = try ContentPage(from: contentFile)
			try page.htmlString.writeToOutputDirectory(path: page.path)

			contentPages.append(page)
		}
	} catch {
		fatalError("\(#function): \(error)")
	}
}

func buildPages() {
	do {
		for page in pages {
			try page.htmlString.writeToOutputDirectory(path: page.path)
		}
	} catch {
		fatalError("\(#function): \(error)")
	}
}
