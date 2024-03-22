//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

struct Section: TagRepresentable {
	var title: String
	var link: (label: String, href: String)?
	var hiddenTitle: Bool = false
	var contentClass: String = "v-gap-l"
	@TagBuilder var content: () -> Tag

	func build() -> Tag {
		SwiftHtml.Section {
			Div {
				H2(title)
					.class("footnote", "monospace")
					.class("sr-only", hiddenTitle)

				if let link {
					P {
						Span("[ ")
						A(link.label)
							.href(link.href)
						Span(" ]")
					}
					.class("footnote", "monospace")
				}
			}
			.class("tertiary", "uppercase")
			.style("display: flex; justify-content: space-between;")

			Div {
				content()
			}
			.class(contentClass)
		}
		.class("v-gap-l")
	}
}
