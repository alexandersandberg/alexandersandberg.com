//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 24.03.24.
//

import Foundation
import SwiftHtml

let lifeLessonListDocument = Document(.html) {
	Div {
		let categories = lifeLessons.reduce(into: [:]) { $0[$1.category, default: 0] += 1 }
		for category in categories.sorted(by: { $0.key < $1.key }) {
			LifeLessonCategoryItem(category: category.key, lessonCount: category.value)
		}
	}
	.class("v-gap-m")
}
