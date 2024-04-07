//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

struct ProjectItem: TagRepresentable {
	var project: Project
	var horizontal: Bool = false

	func build() -> Tag {
		Article {
			VStack(alignment: .leading, spacing: .s8, horizontalFrom: horizontal ? .sm : nil) {
				H3 {
					A(project.title)
						.href(project.href)
				}
				.class("title3 serif")

				if let highlightedText = project.highlightedText, !horizontal {
					Span(highlightedText)
						.style("position: absolute; right: 0; transform: rotate(4deg);")
						.class("caption highlighted-text")
				}

				P(project.description)
					.class(horizontal ? "footnote tertiary" : "secondary")
			}
		}
		.style("position: relative;")
	}
}
