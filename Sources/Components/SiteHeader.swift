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

		return "First published \(publishedAt.dayMonthYear)"
	}

	func build() -> Tag {
		Header {
			VStack(alignment: .leading, spacing: .s16) {
				if let backLink {
					A("↖&ensp;\(backLink.label)")
						.class("plain footnote tertiary")
						.href(backLink.href)
				}

				VStack(alignment: .leading, spacing: .s8) {
					VStack(alignment: .leading) {
						if let supertitle {
							P(supertitle)
								.class("title1 serif tertiary")
						}

						H1(title)
							.class("title1 serif")
					}

					if let subtitle {
						P(subtitle)
							.class("secondary footnote")
					}

					if let date, let datetimeString {
						P {
							Span(updatedAt != nil ? "Updated " : "Published ")
							Time(date.dayMonthYear)
								.datetime(datetimeString)
								.title(timeTitle ?? "")
						}
						.class("secondary footnote")
					}
				}
			}
		}
		.style("position: relative;")
	}
}
