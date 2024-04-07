//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

let aboutDocument = Document(.html) {
	Section(title: "Who") {
		Div {
			P("The all-or-nothing aspect of startups was <b>not something we wanted</b>. Viaweb's hackers were all extremely risk-averse. If there had been some way just to work super hard and get paid for it, without having a lottery mixed in, we would have been delighted.")
		}
		.class("prose")
	}

	Section(title: "What") {
		Div {
			P("We would have much preferred a 100% chance of $1 million to a 20% chance of $10 million, even though theoretically the second is worth twice as much.")
		}
		.class("prose")
	}

	Section(title: "Why") {
		Div {
			P("Unfortunately, there is not currently any <code>space</code> in the business world where you can get the first deal.")
		}
		.class("prose")
	}

	Section(title: "Work") {
		VStack(alignment: .stretch, spacing: .s24) {
			for resource in work {
				LinkedResourceItem(resource: resource, horizontal: true)
			}
		}

		P(#"For my self-published indie apps, take a look at my <a href="/apps">apps page</a>."#)
			.class("callout")
	}

	Img(src: "https://cdn.alexandersandberg.com/desk.png", alt: "Photo of my desk where I work from home")

	Section(title: "Connect") {
		VStack(alignment: .stretch, spacing: .s24) {
			for resource in connect {
				LinkedResourceItem(resource: resource, horizontal: true)
			}
		}
	}
}

let work = [
	LinkedResource(
		title: "Composer",
		href: "https://composer.trade",
		description: "Senior iOS Engineer ⋅ 2023–Now",
		highlightedText: "hello there somewhere!"
	),
	LinkedResource(
		title: "Swift Website Workgroup",
		href: "https://www.swift.org/website-workgroup/",
		description: "Inaugural member ⋅ 2022–Now"
	),
	LinkedResource(
		title: "Practice",
		href: "https://practice.do",
		description: "Senior iOS Engineer ⋅ 2021–2023"
	),
	LinkedResource(
		title: "Tempo",
		href: "https://yourtempo.co",
		description: "Mobile Developer ⋅ 2021"
	)
]

let connect = [
	LinkedResource(
		title: "Email",
		href: "mailto:hi@alexandersandberg.com",
		description: "hi@alexandersandberg.com"
	),
	LinkedResource(
		title: "GitHub",
		href: "https://github.com/alexandersandberg",
		description: "@alexandersandberg"
	),
	LinkedResource(
		title: "Twitter",
		href: "https://twitter.com/alexandberg",
		description: "@alexandberg"
	),
]
