//
//  File.swift
//
//
//  Created by Alexander Sandberg on 22.03.24.
//

import SwiftHtml

let appsDocument = Document(.html) {
	Section(title: "Indie apps") {
		Grid(columns: .c2, spacing: .s32) {
			for resource in indieApps {
				LinkedResourceItem(resource: resource)
			}
		}

		P(#"See <a href="/about/#work">my about page</a> for apps I’ve worked on together with other people."#)
			.class("callout")
	}

	Hr()

	Section(title: "Support") {
		Div {
			P("I’m here to help with any questions or thoughts you might have. I also always love to hear feedback, suggestions, and new ideas for my apps.")

			P("You can reach me by <a href='mailto:\(Site.email)?subject=App support'>sending me an email</a>.")
		}
		.class("prose")
	}

	Hr()

	Section(title: "Privacy") {
		Div {
			H3("Balance")

			P(#"See <a href="https://balance.software/privacy">balance.software/privacy</a>."#)

			H3("Tiny Softbox and Tiny Weather")

			P("I do not collect or store any of your data. That’s it!")
		}
		.class("prose")
	}

	Hr()

	Section(title: "Terms") {
		Div {
			H3("Balance")

			P(#"See <a href="https://balance.software/terms">balance.software/terms</a>."#)

			H3("Tiny Softbox and Tiny Weather")

			P("Tiny Softbox is a paid app. After paying a one-time fee on the App Store, you will have lifetime access to the app on all your devices.")

			P("Tiny Weather is a free app. You can install and use the app and all of its features completely for free. If you would like to support the development of the app, there’s an option to donate from within the app.")

			P(#"<a href="https://www.apple.com/legal/internet-services/itunes/dev/stdeula/">Apple’s Terms of Use (EULA)</a> applies."#)
		}
		.class("prose")
	}
}
