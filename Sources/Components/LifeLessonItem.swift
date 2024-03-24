//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 24.03.24.
//

import SwiftHtml

struct LifeLessonItem: TagRepresentable {
	var lifeLesson: LifeLesson

	func build() -> Tag {
		Article {
			H3("Life lesson #\(lifeLesson.id)")
				.class("sr-only")

			P(lifeLesson.text)

			if let source = lifeLesson.source {
				P(source)
					.class("footnote", "tertiary")
			}
		}
		.class("v-gap-xs")
	}
}
