//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

struct ArticleItem: TagRepresentable {
	var page: ContentPage

	func build() -> Tag {
		Article {
			H3 {
				A(page.title)
					.href(page.path)
			}
			.class("headline")

			if let publishedAt = page.publishedAt {
				P(publishedAt.formatted(date: .abbreviated, time: .omitted))
					.class("footnote", "tertiary")
			}
		}
		.class("v-gap-xs")
	}
}
