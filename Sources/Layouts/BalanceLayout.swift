//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 26.03.24.
//

import SwiftHtml

public struct BalanceLayout: TagRepresentable {
	var title: String
	var description: String?

	func build() -> Tag {
		Html {
			BalanceSiteHead(title: title, description: description, isMainPage: false)

			Body {
				SiteHeader(title: title, backLink: .balance("Balance"))

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
