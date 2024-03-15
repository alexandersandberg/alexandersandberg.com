//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

let homeDocument = Document(.html) {
	Html {
		SiteHead(title: "Alexander Sandberg")

		Body {
			SiteHeader(supertitle: "Carl William", title: "Alexander Sandberg")

			SwiftHtml.Main {
				Section(title: "Bio", hiddenTitle: true) {
					Div {
						P("I’m a self-taught, product-minded iOS/macOS Engineer with a background in web development and product design.")

						P("When asked to describe myself with one word, I often reply with <em>curious</em>.")
					}
					.class("prose")

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
							description: "Virtual softbox to help you improve your lighting."
						),
						Project(
							title: "Tiny Weather",
							href: "/tiny-weather",
							description: "Simple, privacy-minded weather app."
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
							description: "Where I work currently on bringing Composer‘s AI-trading app to iOS."
						),
						Project(
							title: "Swift Website Workgroup",
							href: "https://www.swift.org/website-workgroup",
							description: "Guiding the evolution of Swift.org as a workgroup member."
						),
						Project(
							title: "Tempo",
							href: "https://yourtempo.co",
							description: "Minimalistic email client that helps you focus. Sunset in 2021."
						),
						Project(
							title: "someday.page",
							href: "https://someday.page",
							description: "My someday.page movement, inspired by Derek Sivers‘ now-pages."
						),
						Project(
							title: "Life lessons",
							href: "/life-lessons",
							description: "Lessons and other knowledge I‘ve gathered over the years."
						)
					]
					for project in projects {
						ProjectItem(project: project)
					}
				}

				Hr()

				Section(title: "Articles", contentClass: "v-gap-m") {
					for articlePage in contentPages.articles {
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
