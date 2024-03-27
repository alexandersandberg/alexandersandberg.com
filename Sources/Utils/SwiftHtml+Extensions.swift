//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import Foundation
import SwiftHtml

extension DocumentRenderer {
	public func render(_ document: Document, convertingExternalLinks: Bool) -> String {
		let html = render(document)

		return if convertingExternalLinks {
			html.withConvertedExternalLinks
		} else {
			html
		}
	}
}

extension Tag {
	var name: String {
		self.node.name ?? String(describing: self).lowercased()
	}
}

open class Content: EmptyTag {}

protocol TagRepresentable {
	@TagBuilder func build() -> Tag
}

extension TagBuilder {
	static func buildExpression(_ expression: Tag) -> Tag {
		expression
	}

	static func buildExpression(_ expression: TagRepresentable) -> Tag {
		expression.build()
	}
}

extension Meta {
	func property(_ value: String) -> Self {
		attribute("property", value)
	}
}
