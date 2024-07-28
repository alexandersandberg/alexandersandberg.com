//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 28.07.24.
//

import SwiftHtml

struct MailtoLinkSuffix: TagRepresentable {
	static let htmlString = documentRenderer.render(Document(.unspecified) {
		MailtoLinkSuffix()
	})

	func build() -> Tag {
		Icon(.mailto, size: "0.8em")
			.class("link-suffix footnote tertiary")
			.attribute("aria-hidden", "true")

		Span(" (opens in email client)")
			.class("sr-only unselectable")
	}
}
