//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import Foundation
import SwiftHtml

public struct LifeLessonCategoryLayout: TagRepresentable {
	var title: String
	var lessonCount: Int

	func build() -> Tag {
		Html {
			SiteHead(title: title)

			Body {
				SiteHeader(title: title, subtitle: "\(lessonCount) \(lessonCount == 1 ? "lesson" : "lessons")", backLink: .lifeLessons("Life lessons"))

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
