//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 02.04.24.
//

import SwiftHtml

open class Stack: Tag {
	enum Direction: String {
		case vertical
		case horizontal

		var `class`: String {
			rawValue
		}
	}

	enum Alignment: String {
		case leading
		case center
		case trailing
		case stretch

		var `class`: String {
			rawValue
		}
	}

	enum Breakpoint: String {
		case sm

		var `class`: String {
			"@\(rawValue)"
		}
	}

	open override class func createNode() -> Node {
		Node(type: .standard, name: "div")
	}

	init(
		direction: Stack.Direction,
		alignment: Stack.Alignment,
		spacing: Spacing,
		horizontalFrom: Stack.Breakpoint? = nil,
		@TagBuilder builder: () -> Tag
	) {
		super.init([builder()])

		var classes = [
			"stack",
			direction.class,
			alignment.class,
			spacing.class
		]

		if let horizontalFrom {
			classes.append("horizontal horizontal@\(horizontalFrom)")
		}

		setAttributes([
			.init(key: "class", value: classes.joined(separator: " "))
		])
	}
}

class VStack: Stack {
	init(
		alignment: Stack.Alignment = .center,
		spacing: Spacing = .s0,
		horizontalFrom: Stack.Breakpoint? = nil,
		@TagBuilder builder: () -> Tag
	) {
		super.init(direction: .vertical, alignment: alignment, spacing: spacing, horizontalFrom: horizontalFrom, builder: builder)
	}
}

class HStack: Stack {
	init(
		alignment: Stack.Alignment = .center,
		spacing: Spacing = .s0,
		@TagBuilder builder: () -> Tag
	) {
		super.init(direction: .horizontal, alignment: alignment, spacing: spacing, builder: builder)
	}
}
