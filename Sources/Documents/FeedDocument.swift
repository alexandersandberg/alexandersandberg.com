//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 24.03.24.
//

import Foundation
import SwiftRss

let dateFormatter = {
	let formatter = DateFormatter()

	formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
	formatter.locale = Locale(identifier: "en_US")
	formatter.timeZone = TimeZone(secondsFromGMT: 0)

	return formatter
}()

let rssDocument = Document(.xml) {
	Rss {
		Channel {
			Title(Site.author)
			Description(Site.bio.strippedOfHtmlTags)
			SwiftRss.Link(Site.url)
			Language("en-us")

			let channelPubDate = pages
				.compactMap { $0.updatedAt ?? $0.publishedAt }
				.max()
			if let channelPubDate {
				PubDate(dateFormatter.string(from: channelPubDate))
			}

			LastBuildDate(dateFormatter.string(from: .now))

			AtomLink()
				.attribute("href", "\(Site.url)feed.rss")
				.attribute("rel", "self")
				.attribute("type", "application/rss+xml")

			for page in pages {
				if let pubDate = page.updatedAt ?? page.publishedAt {
					Item {
						Title(page.title)
						if let description = page.description {
							Description(description)
						}

						let link = "\(Site.url)\(page.path)"
						SwiftRss.Link(link)

						if page.feedSettings.treatUpdatedAsNew {
							Guid("\(link),\(dateFormatter.string(from: page.updatedAt ?? pubDate))")
								.isPermalink(false)
						} else {
							Guid(link)
								.isPermalink(true)
						}

						PubDate(dateFormatter.string(from: pubDate))
					}
				}
			}
		}
	}
	.attribute("version", "2.0")
	.attribute("xmlns:atom", "http://www.w3.org/2005/Atom")
}
