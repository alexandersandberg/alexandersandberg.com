//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

struct Section: TagRepresentable {
	var title: String
	var hiddenTitle: Bool = false
	var contentClass: String = "v-gap-l"
	@TagBuilder var content: () -> Tag

	func build() -> Tag {
		SwiftHtml.Section {
			H2(title)
				.class("footnote", "monospace", "tertiary", "uppercase")
				.class("sr-only", hiddenTitle)

			Div {
				content()
			}
			.class(contentClass)
		}
		.class("v-gap-m")
	}
}
