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
							.class("quaternary")

						A(link.label)
							.class("plain")
							.href(link.href)

						Span(" ]")
							.class("quaternary")
					}
					.class("footnote", "monospace")
				}
			}
			.class("tertiary", "uppercase", "flex", "between")

			Div {
				content()
			}
			.class(contentClass)
		}
		.class("v-gap-m")
	}
}
