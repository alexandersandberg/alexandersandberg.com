//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

struct Project {
	var title: String
	var href: String
	var description: String
	var highlightedText: String?
}

struct ProjectItem: TagRepresentable {
	var project: Project

	var isExternal: Bool {
		project.href.starts(with: "https://")
	}

	func build() -> Tag {
		Article {
			H3 {
				A(project.title)
					.href(project.href)
					.target(.blank, isExternal)

				if isExternal {
					Span("↗")
						.class("external-icon", "tertiary", "footnote")
				}
			}
			.class("title3", "serif")

			if let highlightedText = project.highlightedText {
				Span(highlightedText)
					.style("position: absolute; top: -0.4rem; right: 0;  transform: rotate(4deg);")
					.class("caption", "highlighted-text")
			}

			P(project.description)
				.class("secondary")
		}
		.style("position: relative;")
		.class("v-gap-s")
	}
}
