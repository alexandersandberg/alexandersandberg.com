//
//  File.swift
//  alexandersandberg.com
//
//  Created by Alexander Sandberg on 15.02.25.
//

import SwiftHtml

struct NewsletterSubscriptionBox: TagRepresentable {
	func build() -> Tag {
		Aside {
			VStack(alignment: .center, spacing: .s24) {
				VStack(alignment: .center, spacing: .s16) {
					H2("Follow me via email")
						.class("title2 serif medium")

					VStack(alignment: .center, spacing: .s8) {
						P("I dream of the day I can delete all my social media accounts.")
							.class("footnote secondary")

						P("I don’t want to lose the connections though, so I run a <em>very casual</em> email newsletter as a way to stay in touch with me.")
							.class("footnote secondary")

						P {
							Span("You can subscribe here to stay up-to-date with my ")

							A("/notes")
								.href("/notes")

							Span(", ")

							A("/articles")
								.href("/articles")

							Span(", private app beta invites, and other occasional life updates.")
						}
						.class("footnote secondary")
					}
				}

				Form {
					HStack {
						Input()
							.type(.email)
							.name("email")
							.placeholder("your@email.com")
							.required()

						Button("Subscribe")
							.id("submit-button")
							.type(.submit)
					}
				}
				.id("subscription-form")
				.method(.post)

				Script()
					.src("/newsletter-subscription.js")
					.defer()

				P {
					Span("Subscribed! Feel free to ")

					A("introduce yourself")
						.href("mailto:hi@alexandersandberg.com?subject=Hi!")

					Span(" if you want.")
				}
				.id("success-message")
				.class("footnote secondary")
				.style("display: none;")

				P {
					Span("Something went wrong. Please ")

					A("contact me")
						.href("mailto:hi@alexandersandberg.com?subject=Subscription error")

					Span(" if the issue persists.")
				}
				.id("error-message")
				.class("footnote secondary")
				.style("display: none;")
			}
		}
		.class("subscription-box")
	}
}
