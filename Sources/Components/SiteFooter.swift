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
	}

	var variant: Variant?
	var commentSubject: String?

	func build() -> Tag {
		Footer {
			Hr()

			Div {
				if variant == .home {
					Div {
						Span("©")

						A("Colophon")
							.class("plain")
							.href("/colophon")

						A("RSS")
							.class("plain")
							.href("/feed.rss")
					}
					.class("flex gap-m")

					A("Updated \(Date.now.formatted(date: .abbreviated, time: .omitted))")
						.class("plain wide-only")
						.href("https://github.com/alexandersandberg/alexandersandberg.com/commits/main/")
						.target(.blank)
				} else {
					A("↑&ensp;Back to top")
						.class("plain footnote tertiary")
						.href("#top")

					if let commentSubject {
						A("Leave a comment")
							.class("plain wide-only")
							.href("mailto:\(Site.email)?subject=Comment: \(commentSubject)")
					}
				}
			}
			.class("footnote tertiary flex between")
		}
		.class("v-gap-m")
	}
}
