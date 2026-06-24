//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 23.03.24.
//

import Foundation

enum Link {
	case home
	case projects(String)
	case apps(String)
	case notes(String)
	case articles(String)
	case lifeLessons(String)

	var label: String {
		switch self {
		case .home:
			"Home"
		case let .projects(label):
			label
		case let .apps(label):
			label
		case let .notes(label):
			label
		case let .articles(label):
			label
		case let .lifeLessons(label):
			label
		}
	}

	var href: String {
		switch self {
		case .home:
			"/"
		case .projects:
			"/projects/"
		case .apps:
			"/apps/"
		case .notes:
			"/notes/"
		case .articles:
			"/articles/"
		case .lifeLessons:
			"/life-lessons/"
		}
	}
}
