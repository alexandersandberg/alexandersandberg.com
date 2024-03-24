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
								.class("title3 serif")
								.href("/about")

							P("Who, What, Why")
								.class("secondary")
						}
						.class("v-gap-xs")

						Div {
							A("Now")
								.class("title3 serif")
								.href("/now")

							P("Short-term focus")
								.class("secondary")
						}
						.class("v-gap-xs")

						Div {
							A("Someday")
								.class("title3 serif")
								.href("/someday")

							P("Long-term goals")
								.class("secondary")
						}
						.class("v-gap-xs")
					}
					.class("grid-3")
				}

				Hr()

				Section(title: "Indie apps", moreLink: .apps("More"), contentClass: "grid-2") {
					for app in indieApps {
						ProjectItem(project: app)
					}
				}

				Hr()

				Section(title: "Other projects", contentClass: "grid-2") {
					let projects = [
						Project(
							title: "Composer",
							href: "https://composer.trade",
							description: "Platform to build, backtest, and execute trading algorithms."
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
							description: "Collection of knowledge I’ve gathered over the years."
						)
					]
					for project in projects {
						ProjectItem(project: project)
					}
				}

				Hr()

				Section(title: "Articles", moreLink: .articles("Archive"), contentClass: "v-gap-m") {
					for articlePage in articles.sorted(by: >).prefix(5) {
						ArticleItem(page: articlePage)
					}
				}
			}
			.class("v-gap-xl")

			SiteFooter(variant: .home)
		}
		.class("v-gap-xl")
	}
	.lang("en")
}
