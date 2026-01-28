//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 29.03.24.
//

import SwiftHtml

struct BalanceSiteHead: TagRepresentable {
	var title: String
	var description: String?
	var isMainPage: Bool

	private var metaDescription: String {
		description ?? "Balance is a time tracking app that helps you balance work and life. Designed and developed by Alexander Sandberg."
	}

	func build() -> Tag {
		Head {
			Meta().charset("utf-8")
			Meta().name(.viewport).content("width=device-width, initial-scale=1, viewport-fit=cover")

			if isMainPage {
				Title(title)
			} else {
				Title("\(title) · Balance")
			}

			Meta().name(.author).content(Site.author)
			Meta().name(.description).content(metaDescription)
			Meta().property("og:description").content(metaDescription)
			Meta().property("og:title").content(title)
			Meta().property("og:image").content("\(Site.cdn)/balance/og.jpg")

			Meta().name("apple-itunes-app").content("app-id=1637311725")

			SwiftHtml.Link(rel: .icon)
				.href("/balance-favicon.ico")
				.sizes("48x48")
			SwiftHtml.Link(rel: .icon)
				.href("/balance-favicon.svg")
				.sizes("any")
				.type("image/svg+xml")
			SwiftHtml.Link(rel: .appleTouchIcon)
				.href("/balance-apple-touch-icon.png")

			let cssHref = "/\(Site.cssFileName)?v=\(assetsHashes[Site.cssFileName] ?? "0")"

			SwiftHtml.Link(rel: .preload)
				.href(cssHref)
				.attribute("as", "style")

			SwiftHtml.Link(rel: .stylesheet)
				.href(cssHref)

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
	}
}
