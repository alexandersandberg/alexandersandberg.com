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
	var subtitle: String?
	var backLink: Link?
	var publishedAt: Date?
	var updatedAt: Date?

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
			if let backLink {
				A("↖&ensp;\(backLink.label)")
					.class("plain", "footnote", "tertiary")
					.href(backLink.href)
			}

			Div {
				Div {
					if let supertitle {
						Span(supertitle)
							.class("title1", "serif", "tertiary")
							.style("line-height: 1;")
					}

					H1(title)
						.class("title1", "serif")
				}

				if let subtitle {
					P(subtitle)
						.class("secondary", "footnote")
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
			.class("v-gap-xs")
		}
		.class("v-gap-s")
		.style("position: relative;")
	}
}
