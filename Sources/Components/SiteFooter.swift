//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import Foundation
import SwiftHtml

struct SiteFooter: TagRepresentable {
	enum Variant {
		case home
		case balance
	}

	var variant: Variant?
	var commentSubject: String?

	private var showNewsletterSubscriptionBox: Bool {
		switch variant {
		case .home, nil:
			true
		case .balance:
			false
		}
	}

	func build() -> Tag {
		Footer {
			VStack(alignment: .stretch, spacing: .s64) {
				VStack(alignment: .stretch, spacing: .s32) {
					Hr()

					Div {
						HStack(spacing: .s24) {
							if variant == .home {
								Span("©")

								A("Colophon")
									.class("plain")
									.href("/colophon/")

								A("RSS")
									.class("plain")
									.href("/feed.rss")

								Spacer()

								// Wrap in span to prevent link suffixes from affecting layout
								Span {
									A("Updated \(Date.now.dayMonthYear)")
										.class("plain")
										.href("https://github.com/alexandersandberg/alexandersandberg.com/commits/main/")
								}
								.class("@sm")
							} else {
								A("↑&ensp;Back to top")
									.class("plain")
									.href("#top")

								if let commentSubject {
									// Wrap in span to prevent link suffixes from affecting layout
									Span {
										A("Email a comment")
											.class("plain")
											.href("mailto:\(Site.email)?subject=Comment: \(commentSubject)")
									}
									.class("@sm")
								}
							}
						}
					}
					.class("footnote tertiary")
				}

				if showNewsletterSubscriptionBox {
					NewsletterSubscriptionBox()
				}
			}
		}
	}
}
