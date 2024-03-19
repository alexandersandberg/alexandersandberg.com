//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

let homeDocument = Document(.html) {
	Html {
		SiteHead(description: Site.bio.strippedOfHtmlTags)

		Body {
			SiteHeader(supertitle: "Carl William", title: "Alexander Sandberg")

			SwiftHtml.Main {
				Section(title: "Bio", hiddenTitle: true) {
					P(Site.bio)

					Div {
						Div {
							A("About")
								.href("/about")

							P("Who, What, and Why")
								.class("secondary")
						}
						.class("v-gap-xs")

						Div {
							A("Now")
								.href("/now")

							P("Short-term focus")
								.class("secondary")
						}
						.class("v-gap-xs")

						Div {
							A("Someday")
								.href("/someday")

							P("Long-term goals")
								.class("secondary")
						}
						.class("v-gap-xs")
					}
					.class("grid-3")
				}

				Hr()

				Section(title: "Indie apps", contentClass: "grid-2") {
					let projects = [
						Project(
							title: "Balance",
							href: "/balance",
							description: "Time-tracking app with a focus on work-life balance.",
							highlightedText: "My latest indie app!"
						),
						Project(
							title: "Tiny Softbox",
							href: "/tiny-softbox",
							description: "Simple softbox for video calls, photography, reading, etc."
						),
						Project(
							title: "Tiny Weather",
							href: "/tiny-weather",
							description: "Minimal weather app that respects your privacy."
						),
					]
					for project in projects {
						ProjectItem(project: project)
					}
				}

				Hr()

				Section(title: "Other projects", contentClass: "grid-2") {
					let projects = [
						Project(
							title: "Composer",
							href: "https://composer.trade",
							description: "Platform to build, backtest, and execute trading algorithms using AI."
						),
						Project(
							title: "Swift Website Workgroup",
							href: "https://www.swift.org/website-workgroup",
							description: "Steering team guiding the evolution of the <a href='https://swift.org' target='_blank'>Swift.org</a> website."
						),
						Project(
							title: "Tempo",
							href: "https://yourtempo.co",
							description: "Minimalistic email client that helps you focus. Sunset in 2021."
						),
						Project(
							title: "someday.page",
							href: "https://someday.page",
							description: "Movement inspiring people to share their long-term goals."
						),
						Project(
							title: "Life lessons",
							href: "/life-lessons",
							description: "Categorized collection of knowledge I‘ve gathered over the years."
						)
					]
					for project in projects {
						ProjectItem(project: project)
					}
				}

				Hr()

				Section(title: "Articles", contentClass: "v-gap-m") {
					for articlePage in contentPages.articles.sorted(by: >) {
						ArticleItem(page: articlePage)
					}
				}
			}
			.class("v-gap-l")

			Hr()

			SiteFooter(variant: .home)
		}
		.class("v-gap-l")
	}
}
