//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import Foundation
import SwiftHtml

struct Page {
	struct FeedSettings {
		var treatUpdatedAsNew = false
		var hidden = false
	}

	var path: String
	var layout: Layout?
	var publishedAt: Date?
	var updatedAt: Date?
	var contentHtmlString: String
	var prettyURL: Bool = true
	var feedSettings: FeedSettings = .init()

	var title: String {
		layout?.title ?? Site.author
	}

	var description: String? {
		layout?.description
	}

	var htmlString: String {
		if let layout {
			layout.htmlString.replacing("<\(Content().name)>", with: contentHtmlString)
		} else {
			contentHtmlString
		}
	}

	var relativePath: String {
		"/" + path + "/"
	}
}

extension Page {
	init(from url: URL) throws {
		let markdown = markdownParser.parse(try String(contentsOf: url))
		let metadata = markdown.metadata

		guard let title = metadata["title"] else {
			throw "\(url.withoutRootPath) missing title metadata"
		}

		let description = metadata["description"]

		let slug = url.deletingPathExtension().lastPathComponent
		guard slug.isValidSlug else {
			throw "\(url.withoutRootPath) has invalid slug: \(slug)"
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

		guard let layoutString = metadata["layout"] else {
			throw "\(url.withoutRootPath) missing layout metadata"
		}

		let layout = Layout(
			name: layoutString,
			title: title,
			description: description,
			publishedAt: publishedAt,
			updatedAt: updatedAt
		)

		guard let layout else {
			throw "\(url.withoutRootPath) uses unsupported layout: \(layoutString)"
		}

		let path = url.deletingPathExtension().path.replacingOccurrences(of: contentDirectory.path + "/", with: "")

		self.path = path
		self.layout = layout
		self.publishedAt = publishedAt
		self.updatedAt = updatedAt
		self.contentHtmlString = "<div class=\"prose\">\(markdown.html)</div>"
		self.prettyURL = metadata["prettyURL"] != "false"

		if case .article = layout {
			self.feedSettings.treatUpdatedAsNew = false
		} else {
			self.feedSettings.treatUpdatedAsNew = true
		}
	}
}

extension Page: Comparable {
	static func < (lhs: Page, rhs: Page) -> Bool {
		lhs.publishedAt ?? lhs.updatedAt ?? .distantPast < rhs.publishedAt ?? rhs.updatedAt ?? .distantPast
	}

	static func == (lhs: Page, rhs: Page) -> Bool {
		lhs.path == rhs.path
	}
}
