//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 28.03.24.
//

import SwiftHtml

struct Recognition {
	var title: String
	var subtitle: String
	var href: String?
	var paragraphs: [String] = []
}

struct RecognitionCard: TagRepresentable {
	var recognition: Recognition

	func build() -> Tag {
		Article {
			VStack(alignment: .leading, spacing: .s8) {
				VStack(alignment: .leading) {
					H3 {
						if let href = recognition.href {
							A(recognition.title)
								.href(href)
						} else {
							Span(recognition.title)
						}
					}
					.class("footnote bold")

					P(recognition.subtitle)
						.class("caption tertiary")
				}

				if !recognition.paragraphs.isEmpty {
					VStack(alignment: .leading, spacing: .s8) {
						for paragraph in recognition.paragraphs {
							P(paragraph)
								.class("footnote secondary")
						}
					}
				}
			}
		}
		.class("callout")
	}
}
