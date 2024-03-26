//
//  File.swift
//
//
//  Created by Alexander Sandberg on 22.03.24.
//

import SwiftHtml

let appsDocument = Document(.html) {
	Section(title: "Indie apps") {
		Div {
			for app in indieApps {
				ProjectItem(project: app)
			}
		}
		.class("grid-2")

		P("See my <a href='/about'>about page</a> for apps I’ve worked on together with other people.")
			.class("callout")
	}

	Hr()

	Section(title: "Support", contentClass: "prose") {
		P("I’m here to help with any questions or thoughts you might have. I also always love to hear feedback, suggestions, and new ideas for my apps.")

		P("You can reach me at <a href='mailto:hi@alexandersandberg.com?subject=App support'>hi@alexandersandberg.com</a>.")

		P("Balance questions? The <a href='/balance/manual'>Owner’s Manual</a> might be able to help.")
			.class("callout")
	}

	Hr()

	Section(title: "Privacy", contentClass: "prose") {
		H3("Balance")

		P("To help me improve the app, some <em>anonymous</em> usage data is collected. No personal data is collected—it’s only stored on your own device.")

		P("I use Mixpanel for this. See <a href='https://mixpanel.com/legal/privacy-policy/'>Mixpanel’s Privacy Statement</a> for more information. If you opted-in during the onboarding, you can opt-out anytime in the Balance app settings.")

		P("I use RevenueCat to help me manage Balance Pro subscriptions. This is also processed <em>anonymously</em>. See <a href='https://www.revenuecat.com/privacy/'>RevenueCat’s Privacy Policy</a> for more information.")

		H3("Tiny Softbox and Tiny Weather")

		P("I do not collect or store any of your data. That’s it!")
	}

	Hr()

	Section(title: "Terms", contentClass: "prose") {
		H3("Balance")

		P("Balance is a “freemium” app which means it’s completely free to install and use, but gives you the option to subscribe to a Pro version to unlock more features.")

		P("These subscriptions are processed and managed by Apple, and you can read more about that in <a href='https://support.apple.com/en-us/HT202023'>Apple’s support article</a>.")

		P("<a href='https://www.apple.com/legal/internet-services/itunes/dev/stdeula/'>Apple’s Terms of Use (EULA)</a> applies.")

		H3("Tiny Softbox and Tiny Weather")

		P("Tiny Softbox is a paid app. After paying a one-time fee on the App Store, you will have lifetime access to the app on all your devices.")

		P("Tiny Weather is a free app. You can install and use the app and all of its features completely for free. If you would like to support the development of the app, there’s an option to donate from within the app.")

		P("<a href='https://www.apple.com/legal/internet-services/itunes/dev/stdeula/'>Apple’s Terms of Use (EULA)</a> applies.")
	}
}
