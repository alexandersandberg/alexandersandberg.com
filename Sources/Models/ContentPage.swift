//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import Foundation

struct ContentPage {
	var path: String
	var layout: Layout
	var publishedAt: Date?
	var updatedAt: Date?
	var contentHtmlString: String

	var title: String {
		layout.title
	}

	var htmlString: String {
		layout.htmlString.replacing("<\(Content().name)>", with: contentHtmlString)
	}
}

extension ContentPage {
	init(from url: URL) throws {
		let markdown = markdownParser.parse(try String(contentsOf: url))
		let metadata = markdown.metadata

		guard let title = metadata["title"] else {
			throw "\(url.withoutRootPath) missing title metadata"
		}

		let slug = url.deletingPathExtension().lastPathComponent
		guard slug.isValidSlug else {
			throw "\(url.withoutRootPath) has invalid slug: \(slug)"
		}

		guard let layoutString = metadata["layout"] else {
			throw "\(url.withoutRootPath) missing layout metadata"
		}

		guard let layout = Layout(name: layoutString, title: title) else {
			throw "\(url.withoutRootPath) uses unsupported layout: \(layoutString)"
		}

		let dateFormat = "yyyy-MM-dd"
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = dateFormat

		var publishedAt: Date? = nil
		if let publishedAtString = metadata["publishedAt"] {
			if let date = dateFormatter.date(from: publishedAtString) {
				publishedAt = date
			} else {
				throw "\(url.withoutRootPath) publishedAt \(publishedAtString) not in required format \(dateFormat)"
			}
		}

		var updatedAt: Date? = nil
		if let updatedAtString = metadata["updatedAt"] {
			if let date = dateFormatter.date(from: updatedAtString) {
				updatedAt = date
			} else {
				throw "\(url.withoutRootPath) updatedAt \(updatedAtString) not in required format \(dateFormat)"
			}
		}

		let path = url.deletingPathExtension().path.replacingOccurrences(of: contentDirectory.path + "/", with: "")

		self.path = path
		self.layout = layout
		self.publishedAt = publishedAt
		self.updatedAt = updatedAt
		self.contentHtmlString = markdown.html
	}
}

extension Array where Element == ContentPage {
	var articles: [ContentPage] {
		self.filter { page in
			if case .article = page.layout {
				true
			} else {
				false
			}
		}
	}
}
