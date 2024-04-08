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
				VStack(alignment: .stretch, spacing: .s48) {
					SiteHeader(title: title, backLink: .home, publishedAt: publishedAt, updatedAt: updatedAt)

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
