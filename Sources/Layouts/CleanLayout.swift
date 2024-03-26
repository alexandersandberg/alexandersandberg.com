//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 25.03.24.
//

import SwiftHtml

public struct CleanLayout: TagRepresentable {
	var title: String
	var description: String?

	func build() -> Tag {
		Html {
			SiteHead(title: title, description: description)

			Body {
				SiteHeader(title: title, backLink: .home)

				SwiftHtml.Main {
					Content()
				}
				.class("v-gap-xl")
			}
			.class("v-gap-xl")
		}
		.lang("en")
	}
}
