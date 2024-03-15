//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

enum Layout {
	case list(title: String)
	case page(title: String)
	case article(title: String)

	init?(name string: String, title: String) {
		switch string {
		case "list":
			self = .list(title: title)
		case "page":
			self = .page(title: title)
		case "article":
			self = .article(title: title)
		default:
			return nil
		}
	}

	var title: String {
		switch self {
		case .list(let title), .page(let title), .article(let title): title
		}
	}

	var htmlString: String {
		let layout =  Document(.html) {
			switch self {
			case .list(let title):
				ListLayout(title: title)
			case .page(let title):
				PageLayout(title: title)
			case .article(let title):
				ArticleLayout(title: title)
			}
		}

		return documentRenderer.render(layout)
	}
}
