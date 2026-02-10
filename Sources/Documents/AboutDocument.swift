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
			P("I’m Alex, a self-taught software engineer born and raised in northern Sweden. I currently live in Austria.")
			P("I’m very much driven by curiosity. I’ve always loved creating things, exploring new ideas, and seeking new knowledge to learn from.")
			P("I have a big appreciation for good design and polished experiences and consider myself a product-minded engineer. I actually have a master’s degree in product design as well.")
			P("I’m open-minded; I embrace my mistakes and learn from them. I avoid prejudices and find opposing views to my own fascinating, not threatening.")
			P("I’m an extroverted introvert; while I love meeting new people and exploring new places, I recharge my energy at home.")
			P("I like to keep things simple, both in work and in life. You can usually see this reflected in my creative output.")
		}
		.class("prose")
	}

	Hr()

	Section(title: "What") {
		Div {
			P("I love turning ideas into reality—<em>making things</em>. Nowadays, I spend most of my time carefully crafting simple but beautiful apps and experiences with Swift and SwiftUI.")
			P(#"I work as the Lead iOS Engineer at <a href="https://www.composer.trade/">Composer</a> where I’m in charge of our iOS app."#)
			P(#"I’m working on a time tracking app called <a href="https://balance.software">Balance</a> that helps you balance work and life."#)
			P(#"I’m also a member of the <a href="https://www.swift.org/website-workgroup/">Swift Website Workgroup</a> where I help guide the evolution of the <a href="https://www.swift.org">Swift.org</a> website."#)
			P(#"You can read more about what I’m up to right now on <a href="/now/">my now page</a>."#)
				.class("callout")
		}
		.class("prose")
	}

	Hr()

	Section(title: "Why") {
		Div {
			P("I think I’ve always had a deep curiosity for learning and creating. As long as I can remember, I’ve always found great joy in reading, puzzling, drawing, building with LEGO… anything creative, really.")
			P("Ever since I wrote my first lines of code back in 2007, when I was 13 years old, most of my creative output has been in the form of software projects—apps, websites, tools.")
			P("I’ve also always been a perfectionist—for better or worse. In later years, this has made me gravitate toward simplicity in my work, and I’ve come to highly regard the work of people like Dieter Rams and Steve Jobs.")
			P("This desire for keeping things simple might also have come from my Scandinavian roots, where minimalism is more than just a design trend.")
			P("At the intersection of my need for innovation and simplistic perfectionism, I have discovered this passion for <em>software tinkering</em>.")
			P(#"On <a href="/someday/">my someday page</a>, you can learn more about my long-term life goals."#)
				.class("callout")
		}
		.class("prose")
	}

	Hr()

	Section(title: "Work") {
		VStack(alignment: .stretch, spacing: .s24) {
			for resource in work {
				LinkedResourceItem(resource: resource, horizontal: true)
			}
		}

		P(#"You can find my self-published indie apps on <a href="/apps/">my apps page</a>."#)
			.class("callout")
	}

	Img(src: "https://cdn.alexandersandberg.com/desk.png", alt: "Photo of my desk where I work from home")

	Section(title: "Connect") {
		VStack(alignment: .stretch, spacing: .s24) {
			for resource in connect {
				LinkedResourceItem(resource: resource, horizontal: true)
			}
		}

		P(#"I plan to one day <a href="/quitting-social-media/">quit social media</a>, but until then you can still find me there."#)
			.class("callout")
	}
}

let work = [
	LinkedResource(
		title: "Composer",
		href: "https://composer.trade",
		description: "Lead iOS Engineer ⋅ 2023–Now"
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
		description: "Mobile Engineer ⋅ 2021"
	),
	LinkedResource(
		title: "Newsadoo",
		href: "https://newsadoo.com",
		description: "Mobile + Frontend ⋅ 2019–2021"
	)
]

let connect = [
	LinkedResource(
		title: "Email",
		href: "mailto:hi@alexandersandberg.com",
		description: "hi@alexandersandberg.com",
		highlightedText: "Preferred!"
	),
	LinkedResource(
		title: "LinkedIn",
		href: "https://www.linkedin.com/in/alexandberg/",
		description: "@alexandberg"
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
	LinkedResource(
		title: "Bluesky",
		href: "https://bsky.app/profile/alexandersandberg.com",
		description: "@alexandersandberg.com"
	),
]
