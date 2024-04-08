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
	@TagBuilder var content: () -> Tag

	func build() -> Tag {
		SwiftHtml.Section {
			VStack(alignment: .stretch, spacing: .s32) {
				HStack(spacing: .s8) {
					H2(title)
						.class("footnote monospace tertiary uppercase")

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
						.class("footnote monospace tertiary uppercase")
					}
				}
				.class("sr-only", hiddenTitle)

				content()
			}
		}
		.id(title.slug)
	}
}
