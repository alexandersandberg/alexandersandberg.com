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
			VStack(alignment: .stretch, spacing: .s48) {
				SiteHeader(supertitle: "Carl William", title: "Alexander Sandberg")

				SwiftHtml.Main {
					VStack(alignment: .stretch, spacing: .s48) {
						BioSection()

						Hr()

						IndieAppsSection()

						Hr()

						OtherProjectsSection()

						Hr()

						ArticlesSection()
					}
				}

				SiteFooter(variant: .home)
			}
		}
	}
	.lang("en")
}

private struct BioSection: TagRepresentable {
	func build() -> Tag {
		Section(title: "Bio", hiddenTitle: true) {
			VStack(alignment: .stretch, spacing: .s48) {
				P(Site.bio)

				VStack(alignment: .leading, spacing: .s32, horizontalFrom: .sm) {
					VStack(alignment: .leading, spacing: .s8) {
						A("About")
							.class("title3 serif")
							.href("/about/")

						P("Who, What, Why")
							.class("secondary")
					}

					VStack(alignment: .leading, spacing: .s8) {
						A("Now")
							.class("title3 serif")
							.href("/now/")

						P("Short-term focus")
							.class("secondary")
					}

					VStack(alignment: .leading, spacing: .s8) {
						A("Someday")
							.class("title3 serif")
							.href("/someday/")

						P("Long-term goals")
							.class("secondary")
					}
				}
			}
		}
	}
}

private struct IndieAppsSection: TagRepresentable {
	func build() -> Tag {
		Section(title: "Indie apps", moreLink: .apps("Details")) {
			Grid(columns: .c2, spacing: .s32) {
				for app in indieApps {
					ProjectItem(project: app)
				}
			}
		}
	}
}

private struct OtherProjectsSection: TagRepresentable {
	func build() -> Tag {
		Section(title: "Other projects") {
			Grid(columns: .c2, spacing: .s32) {
				for project in otherProjects {
					ProjectItem(project: project)
				}
			}
		}
	}
}

private struct ArticlesSection: TagRepresentable {
	func build() -> Tag {
		Section(title: "Articles", moreLink: .articles("Archive")) {
			VStack(alignment: .leading, spacing: .s32) {
				for articlePage in articles.sorted(by: >).prefix(5) {
					ArticleItem(page: articlePage)
				}
			}
		}
	}
}

let otherProjects = [
	Project(
		title: "Composer",
		href: "https://composer.trade",
		description: "Platform to build, backtest, and execute trading algorithms."
	),
	Project(
		title: "Swift Website Workgroup",
		href: "https://www.swift.org/website-workgroup",
		description: "Steering team guiding the evolution of the Swift.org website."
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
		href: "/life-lessons/",
		description: "Collection of knowledge I’ve gathered over the years."
	)
]
