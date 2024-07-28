//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 26.03.24.
//

import SwiftHtml

struct ExternalLinkSuffix: TagRepresentable {
	static let htmlString = documentRenderer.render(Document(.unspecified) {
		ExternalLinkSuffix()
	})

	func build() -> Tag {
		Span("↗")
			.class("link-suffix footnote tertiary unselectable")
			.attribute("aria-hidden", "true")

		Span(" (opens in new tab)")
			.class("sr-only unselectable")
	}
}
