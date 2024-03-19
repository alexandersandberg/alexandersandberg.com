//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import Foundation
import SwiftHtml

enum Layout {
	case list(title: String, description: String? = nil)
	case page(title: String, description: String? = nil, publishedAt: Date? = nil, updatedAt: Date? = nil)
	case article(title: String, description: String? = nil, publishedAt: Date? = nil, updatedAt: Date? = nil)

	init?(name string: String, title: String, description: String?, publishedAt: Date?, updatedAt: Date?) {
		switch string {
		case "list":
			self = .list(title: title, description: description)
		case "page":
			self = .page(title: title, description: description, publishedAt: publishedAt, updatedAt: updatedAt)
		case "article":
			self = .article(title: title, description: description, publishedAt: publishedAt, updatedAt: updatedAt)
		default:
			return nil
		}
	}

	var title: String {
		switch self {
		case .list(let title, _): title
		case .page(let title, _, _, _): title
		case .article(let title, _, _, _): title
		}
	}

	var htmlString: String {
		let layout =  Document(.html) {
			switch self {
			case let .list(title, description):
				ListLayout(title: title, description: description)
			case let .page(title, description, publishedAt, updatedAt):
				PageLayout(title: title, description: description, publishedAt: publishedAt, updatedAt: updatedAt)
			case let .article(title, description, publishedAt, updatedAt):
				ArticleLayout(title: title, description: description, publishedAt: publishedAt, updatedAt: updatedAt)
			}
		}

		return documentRenderer.render(layout)
	}
}
