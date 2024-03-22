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
					.href(page.relativePath)
			}
			.class("title3", "serif")

			if let publishedAt = page.publishedAt {
				P(publishedAt.formatted(date: .abbreviated, time: .omitted))
					.class("footnote", "secondary")
			}
		}
		.class("v-gap-xs")
	}
}
