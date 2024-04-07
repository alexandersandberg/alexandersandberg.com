//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

struct ArticleItem: TagRepresentable {
	var page: Page

	func build() -> Tag {
		Article {
			VStack(alignment: .leading, spacing: .s4) {
				H3 {
					A(page.title)
						.href(page.relativePath)
						.style("display: inline-block;") // Fix gap in clickable link if multiple rows
				}
				.class("title3 serif")

				if let publishedAt = page.publishedAt {
					P(publishedAt.formatted(date: .abbreviated, time: .omitted))
						.class("footnote secondary")
				}
			}
		}
	}
}
