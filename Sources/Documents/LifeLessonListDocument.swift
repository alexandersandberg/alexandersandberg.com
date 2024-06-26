//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 24.03.24.
//

import Foundation
import SwiftHtml

func lifeLessonListDocument(categories: [LifeLesson.Category : [LifeLesson]]) -> Document {
	Document(.html) {
		VStack(alignment: .stretch, spacing: .s32) {
			for category in categories.sorted(by: { $0.key < $1.key }) {
				LifeLessonCategoryItem(category: category.key, lessonCount: category.value.count)
			}
		}
	}
}
