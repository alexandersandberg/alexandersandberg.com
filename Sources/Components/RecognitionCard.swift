//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 28.03.24.
//

import SwiftHtml

struct RecognitionCard: TagRepresentable {
	var title: String
	var subtitle: String
	var href: String?
	@TagBuilder var content: () -> Tag

	func build() -> Tag {
		Article {
			Div {
				H3 {
					if let href {
						A(title)
							.href(href)
					} else {
						Span(title)
					}
				}
				.class("footnote bold")

				P(subtitle)
					.class("caption tertiary")
			}

			if content().name != EmptyTag().name {
				Div {
					content()
				}
				.class("recognition-card-content")
			}
		}
		.class("callout v-gap-xs")
		.style("text-align: left;")
	}
}

extension RecognitionCard {
	init(title: String, subtitle: String, href: String? = nil) {
		self.title = title
		self.subtitle = subtitle
		self.href = href
		self.content = { EmptyTag() }
	}
}
