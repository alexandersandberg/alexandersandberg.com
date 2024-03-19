//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

public struct ListLayout: TagRepresentable {
	var title: String
	var description: String?

	func build() -> Tag {
		Html {
			SiteHead(title: title, description: description)

			Body {
				SiteHeader(title: title)

				SwiftHtml.Main {
					Content()
				}
				.class("v-gap-l")

				Hr()

				SiteFooter()
			}
			.class("v-gap-l")
		}
	}
}
