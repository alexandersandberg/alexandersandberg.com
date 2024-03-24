//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 24.03.24.
//

import Foundation
import SwiftHtml

let lifeLessonsDocument = Document(.html) {
	Div {
		for lifeLesson in lifeLessons.sorted(by: >) {
			LifeLessonItem(lifeLesson: lifeLesson)
		}
	}
	.class("v-gap-m")
}
