//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 23.03.24.
//

import Foundation

enum Link {
	case home
	case apps(String)
	case articles(String)
	case lifeLessons(String)

	var label: String {
		switch self {
		case .home:
			"Home"
		case .apps(let label):
			label
		case .articles(let label):
			label
		case .lifeLessons(let label):
			label
		}
	}

	var href: String {
		switch self {
		case .home:
			"/"
		case .apps:
			"/apps"
		case .articles:
			"/articles"
		case .lifeLessons:
			"/life-lessons"
		}
	}
}
