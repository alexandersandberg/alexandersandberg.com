//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

public struct LifeLessonCategoryLayout: TagRepresentable {
	var title: String
	var lessonCount: Int
	var canonicalHref: String

	func build() -> Tag {
		Html {
			SiteHead(title: title, canonicalHref: canonicalHref)

			Body {
				VStack(alignment: .stretch, spacing: .s64) {
					SiteHeader(title: title, subtitle: "\(lessonCount) \(lessonCount == 1 ? "lesson" : "lessons")", backLink: .lifeLessons("Life lessons"))

					SwiftHtml.Main {
						VStack(alignment: .stretch, spacing: .s64) {
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
