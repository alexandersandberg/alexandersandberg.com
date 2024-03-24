//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 24.03.24.
//

import Foundation
import SwiftHtml

let lifeLessons = JSONDecoder().decode([LifeLesson].self, from: "life_lessons.json")

let lifeLessonsDocument = Document(.html) {
	Div {
		for lifeLesson in lifeLessons.sorted(by: >) {
			LifeLessonItem(lifeLesson: lifeLesson)
		}
	}
	.class("v-gap-m")
}
