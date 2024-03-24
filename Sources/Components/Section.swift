//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

struct Section: TagRepresentable {
	var title: String
	var moreLink: Link?
	var hiddenTitle: Bool = false
	var contentClass: String = "v-gap-l"
	@TagBuilder var content: () -> Tag

	func build() -> Tag {
		SwiftHtml.Section {
			Div {
				H2(title)
					.class("footnote monospace")
					.class("sr-only", hiddenTitle)

				if let moreLink {
					P {
						Span("[ ")
							.class("quaternary")

						A(moreLink.label)
							.class("plain")
							.href(moreLink.href)

						Span(" ]")
							.class("quaternary")
					}
					.class("footnote monospace")
				}
			}
			.class("tertiary uppercase flex between")

			Div {
				content()
			}
			.class(contentClass)
		}
		.class("v-gap-m")
	}
}
