//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import Foundation
import SwiftHtml

struct SiteHeader: TagRepresentable {
	var supertitle: String?
	var title: String
	var publishedAt: Date? = nil
	var updatedAt: Date? = nil

	private var date: Date? {
		updatedAt ?? publishedAt
	}

	private var datetimeString: String? {
		guard let date else { return nil }

		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"

		return formatter.string(from: date)
	}

	private var timeTitle: String? {
		guard let publishedAt, updatedAt != nil else { return nil }

		return "First published \(publishedAt.formatted(date: .abbreviated, time: .omitted))"
	}

	func build() -> Tag {
		Header {
			Div {
				Span(supertitle ?? "&nbsp;")
					.class("title1", "serif", "tertiary")
					.style("position: relative; top: 0.25rem; \(supertitle == nil ? "visibility: hidden" : "")")

				H1(title)
					.class("title1", "serif")
			}

			if let date, let datetimeString {
				P {
					Span(updatedAt != nil ? "Updated " : "Published ")
					Time(date.formatted(date: .abbreviated, time: .omitted))
						.datetime(datetimeString)
						.title(timeTitle ?? "")
				}
				.class("secondary", "footnote")
			}
		}
		.class("v-gap-s")
	}
}
