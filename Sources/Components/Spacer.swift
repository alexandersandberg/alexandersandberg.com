//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 04.04.24.
//

import SwiftHtml

struct Spacer: TagRepresentable {
	func build() -> Tag {
		Div()
			.class("spacer")
	}
}
