//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

struct LinkedResource {
	var title: String
	var href: String
	var description: String
	var highlightedText: String?
}

struct LinkedResourceItem: TagRepresentable {
	var resource: LinkedResource
	var horizontal: Bool = false

	func build() -> Tag {
		Article {
			VStack(alignment: .leading, spacing: .s8, horizontalFrom: horizontal ? .sm : nil) {
				HStack(spacing: .s16) {
					H3 {
						A(resource.title)
							.href(resource.href)
					}
					.class("title3 serif")

					if let highlightedText = resource.highlightedText, horizontal {
						Span(highlightedText)
							.style("transform: rotate(-2deg);")
							.class("caption highlighted-text")
					}
				}

				if let highlightedText = resource.highlightedText, !horizontal {
					Span(highlightedText)
						.style("position: absolute; right: 0; transform: rotate(4deg);")
						.class("caption highlighted-text")
				}

				P(resource.description)
					.class(horizontal ? "footnote tertiary" : "secondary")
			}
		}
		.style("position: relative;")
	}
}
