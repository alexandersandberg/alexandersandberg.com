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
				VStack(alignment: .stretch, spacing: .s48) {
					SiteHeader(title: title, backLink: .home)

					SwiftHtml.Main {
						VStack(alignment: .stretch, spacing: .s48) {
							Content()
						}
					}

					SiteFooter()
				}
			}
		}
		.lang("en")
	}
}
