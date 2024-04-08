//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 06.04.24.
//

import Foundation

enum Spacing: String {
	case s0
	case s2
	case s4
	case s8
	case s16
	case s24
	case s32
	case s48
	case s64
	case s80

	var `class`: String {
		rawValue
	}
}
