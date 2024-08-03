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
	case notes(String)
	case articles(String)
	case lifeLessons(String)
	case balance(String)

	var label: String {
		switch self {
		case .home:
			"Home"
		case let .apps(label):
			label
		case let .notes(label):
			label
		case let .articles(label):
			label
		case let .lifeLessons(label):
			label
		case let .balance(label):
			label
		}
	}

	var href: String {
		switch self {
		case .home:
			"/"
		case .apps:
			"/apps/"
		case .notes:
			"/notes/"
		case .articles:
			"/articles/"
		case .lifeLessons:
			"/life-lessons/"
		case .balance:
			"/balance/"
		}
	}
}
