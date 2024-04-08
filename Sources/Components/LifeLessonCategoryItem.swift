//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 24.03.24.
//

import SwiftHtml

struct LifeLessonCategoryItem: TagRepresentable {
	var category: LifeLesson.Category
	var lessonCount: Int

	func build() -> Tag {
		Article {
			VStack(alignment: .leading, spacing: .s4) {
				H3 {
					A(category.title)
						.href(category.relativePath)
						.style("display: inline-block;") // Fix gap in clickable link if multiple rows
				}
				.class("title3 serif")

				P("\(lessonCount) \(lessonCount == 1 ? "lesson" : "lessons")")
					.class("footnote secondary")
			}
		}
	}
}
