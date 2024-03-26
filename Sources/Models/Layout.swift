//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import Foundation
import SwiftHtml

enum Layout {
	case clean(title: String, description: String? = nil)
	case list(title: String, description: String? = nil)
	case page(title: String, description: String? = nil, publishedAt: Date? = nil, updatedAt: Date? = nil)
	case article(title: String, description: String? = nil, publishedAt: Date? = nil, updatedAt: Date? = nil)
	case lifeLessonCategory(title: String, lessonCount: Int)
	case balance(title: String, description: String? = nil)

	var title: String {
		switch self {
		case let .clean(title, _): title
		case let .list(title, _): title
		case let .page(title, _, _, _): title
		case let .article(title, _, _, _): title
		case let .lifeLessonCategory(title, _): title
		case let .balance(title, _): title
		}
	}

	var description: String? {
		switch self {
		case let .clean(_, description): description
		case let .list(_, description): description
		case let .page(_, description, _, _): description
		case let .article(_, description, _, _): description
		case let .balance(_, description): description
		default: nil
		}
	}

	var htmlString: String {
		let layout =  Document(.html) {
			switch self {
			case let .clean(title, description):
				CleanLayout(title: title, description: description)
			case let .list(title, description):
				ListLayout(title: title, description: description)
			case let .page(title, description, publishedAt, updatedAt):
				PageLayout(title: title, description: description, publishedAt: publishedAt, updatedAt: updatedAt)
			case let .article(title, description, publishedAt, updatedAt):
				ArticleLayout(title: title, description: description, publishedAt: publishedAt, updatedAt: updatedAt)
			case let .lifeLessonCategory(title, lessonCount):
				LifeLessonCategoryLayout(title: title, lessonCount: lessonCount)
			case let .balance(title, description):
				BalanceLayout(title: title, description: description)
			}
		}

		return documentRenderer.render(layout)
	}
}

extension Layout {
	init?(name string: String, title: String, description: String?, publishedAt: Date?, updatedAt: Date?) {
		switch string {
		case "clean":
			self = .clean(title: title, description: description)
		case "list":
			self = .list(title: title, description: description)
		case "page":
			self = .page(title: title, description: description, publishedAt: publishedAt, updatedAt: updatedAt)
		case "article":
			self = .article(title: title, description: description, publishedAt: publishedAt, updatedAt: updatedAt)
		case "balance":
			self = .balance(title: title, description: description)
		default:
			return nil
		}
	}
}
