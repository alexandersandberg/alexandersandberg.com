//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import Foundation
import SwiftHtml

enum Layout {
	case list(title: String)
	case page(title: String, publishedAt: Date? = nil, updatedAt: Date? = nil)
	case article(title: String, publishedAt: Date? = nil, updatedAt: Date? = nil)

	init?(name string: String, title: String, publishedAt: Date? = nil, updatedAt: Date? = nil) {
		switch string {
		case "list":
			self = .list(title: title)
		case "page":
			self = .page(title: title, publishedAt: publishedAt, updatedAt: updatedAt)
		case "article":
			self = .article(title: title, publishedAt: publishedAt, updatedAt: updatedAt)
		default:
			return nil
		}
	}

	var title: String {
		switch self {
		case .list(let title), .page(let title, _, _), .article(let title, _, _): title
		}
	}

	var htmlString: String {
		let layout =  Document(.html) {
			switch self {
			case let .list(title):
				ListLayout(title: title)
			case let .page(title, publishedAt, updatedAt):
				PageLayout(title: title, publishedAt: publishedAt, updatedAt: updatedAt)
			case let .article(title, publishedAt, updatedAt):
				ArticleLayout(title: title, publishedAt: publishedAt, updatedAt: updatedAt)
			}
		}

		return documentRenderer.render(layout)
	}
}
