//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 03.08.24.
//

import Foundation
import SwiftHtml

struct NoteItem: TagRepresentable {
	var note: Note
	var withPermalink: Bool = false

	private var datetimeString: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"

		return formatter.string(from: note.publishedAt)
	}

	func build() -> Tag {
		Article {
			VStack(alignment: .leading, spacing: .s16) {
				H3("Note #\(note.id)")
					.class("sr-only")

				Div(note.contentHtmlString)
					.class("prose compact")

				P {
					A("#\(note.id)")
						.class("plain")
						.href("\(Link.notes("").href)#\(note.id)")

					Span(" · ")

					Time(note.publishedAt.dayMonthYear)
						.datetime(datetimeString)

					Span {
						Span(" · ")

						A("Reply by email")
							.class("plain")
							.href("mailto:\(Site.email)?subject=Reply: Note #\(note.id)")
					}
					.class("@sm comment-link footnote tertiary")
				}
				.class("footnote tertiary")
			}
		}
		.id("\(note.id)")
		.class("note")
	}
}
