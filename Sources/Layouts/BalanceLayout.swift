//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 26.03.24.
//

import SwiftHtml

public struct BalanceLayout: TagRepresentable {
	var title: String
	var description: String?

	private var isBalanceMainPage: Bool {
		title == "Balance"
	}

	private var metaDescription: String {
		description ?? "Balance is a time tracking app with a focus on work-life balance, designed and developed by Alexander Sandberg."
	}

	func build() -> Tag {
		Html {
			Head {
				Meta().charset("utf-8")
				Meta().name(.viewport).content("width=device-width, initial-scale=1, viewport-fit=cover")

				if isBalanceMainPage {
					Title("Balance")
				} else {
					Title("\(title) · Balance")
				}

				Meta().name(.author).content(Site.author)
				Meta().name(.description).content(metaDescription)
				Meta().property("og:description").content(metaDescription)
				Meta().property("og:title").content(title)
				Meta().property("og:image").content("\(Site.cdn)/balance-og.png")

				SwiftHtml.Link(rel: .icon)
					.href("/balance-favicon.ico")
				SwiftHtml.Link(rel: .appleTouchIcon)
					.href("/balance-apple-touch-icon.png")

				SwiftHtml.Link(rel: .stylesheet)
					.href("/\(Site.cssFileName)?v=\(assetsHashes[Site.cssFileName] ?? "0")")

				Script()
					.defer()
					.data(key: "domain", "alexandersandberg.com")
					.src("https://plausible.io/js/plausible.js")
				Script()
					.async()
					.defer()
					.data(key: "domain", "alexandersandberg.com")
					.src("https://plausible.io/js/plausible.outbound-links.js")
			}

			Body {
				SiteHeader(title: title, backLink: isBalanceMainPage ? .apps("Apps") : .balance("Balance"))

				SwiftHtml.Main {
					Content()
				}
				.class("v-gap-xl")
			}
			.class("v-gap-xl")
		}
		.lang("en")
	}
}
