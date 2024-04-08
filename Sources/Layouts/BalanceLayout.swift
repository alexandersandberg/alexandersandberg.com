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
				VStack(alignment: .stretch, spacing: .s48) {
					SiteHeader(title: title, backLink: .balance("Balance"))

					SwiftHtml.Main {
						VStack(alignment: .stretch, spacing: .s48) {
							Content()
						}
					}

					SiteFooter(commentSubject: title)
				}
			}
		}
		.lang("en")
	}
}
