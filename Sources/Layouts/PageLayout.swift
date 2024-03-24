//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import Foundation
import SwiftHtml

public struct PageLayout: TagRepresentable {
	var title: String
	var description: String?
	var publishedAt: Date?
	var updatedAt: Date?

	func build() -> Tag {
		Html {
			SiteHead(title: title, description: description, publishedAt: publishedAt, updatedAt: updatedAt)

			Body {
				SiteHeader(title: title, backLink: .home, publishedAt: publishedAt, updatedAt: updatedAt)

				SwiftHtml.Main {
					Content()
				}
				.class("v-gap-xl")

				SiteFooter(commentSubject: title)
			}
			.class("v-gap-xl")
		}
		.lang("en")
	}
}
