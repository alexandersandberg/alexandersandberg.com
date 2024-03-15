//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

public struct ArticleLayout: TagRepresentable {
	var title: String

	func build() -> Tag {
		Html {
			SiteHead(title: "\(title) · Alexander Sandberg")

			Body {
				SiteHeader(title: title)

				SwiftHtml.Main {
					Content()
				}
				.class("v-gap-l")

				Hr()

				SiteFooter(variant: .article, commentSubject: title)
			}
			.class("v-gap-l")
		}
	}
}
