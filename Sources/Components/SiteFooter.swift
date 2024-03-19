//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import Foundation
import SwiftHtml

struct SiteFooter: TagRepresentable {
	enum Variant {
		case home
		case article
	}

	var variant: Variant?
	var commentSubject: String?

	func build() -> Tag {
		Footer {
			if variant == .home {
				Span("©")

				A("Colophon")
					.class("plain")
					.href("/colophon")

				A("RSS")
					.class("plain")
					.href("/rss.xml")

				A("Updated \(Date.now.formatted(date: .abbreviated, time: .omitted))")
					.style("margin-left: auto;")
					.class("plain wide-only")
					.href("https://github.com/alexandersandberg/alexandersandberg.com/commits/main/")
					.target(.blank)
			} else {
				A("Home")
					.class("plain")
					.href("/")

				if variant == .article {
					Span("/")
						.class("quaternary")

					A("Articles")
						.class("plain")
						.href("/articles")
				}

				if let commentSubject {
					A("Leave a comment")
						.style("margin-left: auto;")
						.class("plain wide-only")
						.href("mailto:\(Site.email)?subject=Comment: \(commentSubject)")
				}
			}
		}
		.style("display: flex; gap: \(variant == .home ? "1.5" : "0.75")rem")
		.class("footnote", "monospace", "tertiary")
	}
}
