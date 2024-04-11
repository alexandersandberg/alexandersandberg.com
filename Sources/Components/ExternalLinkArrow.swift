//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 26.03.24.
//

import SwiftHtml

struct ExternalLinkArrow: TagRepresentable {
	static let htmlString = documentRenderer.render(Document(.unspecified) {
		ExternalLinkArrow()
	})

	func build() -> Tag {
		Span("")
			.class("link-external-icon footnote tertiary")
			.attribute("aria-hidden", "true")

		Span(" (opens in new tab)")
			.class("sr-only")
	}
}
