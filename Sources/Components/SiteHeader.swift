//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

struct SiteHeader: TagRepresentable {
	var supertitle: String?
	var title: String

	func build() -> Tag {
		Header {
			Span(supertitle ?? "&nbsp;")
				.class("title2", "tertiary")
				.style("line-height: 1; \(supertitle == nil ? "visibility: hidden" : "")")

			H1(title)
				.class("title2")
				.style("line-height: 1")
		}
	}
}
