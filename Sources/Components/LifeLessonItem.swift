//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 24.03.24.
//

import SwiftHtml

struct LifeLessonItem: TagRepresentable {
	var lesson: LifeLesson
	var contentHtmlString: String

	func build() -> Tag {
		Article {
			VStack(alignment: .leading, spacing: .s16) {
				H3("Life lesson #\(lesson.id)")
					.class("sr-only")

				Div(contentHtmlString)
					.class("prose compact")

				P {
					A("#\(lesson.id)")
						.class("plain")
						.href("#\(lesson.id)")

					if let source = lesson.source {
						Span(" · \(source)")
					}
				}
				.class("footnote tertiary")
			}
		}
		.id("\(lesson.id)")
	}
}
