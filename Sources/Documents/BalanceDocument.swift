//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 26.03.24.
//

import SwiftHtml

let balanceDocument = Document(.html) {
	Html {
		SiteHead(description: Site.bio.strippedOfHtmlTags)

		Body {
			Header {
				Div {
					Img(src: Site.cdn + "/balance/icon.png", alt: "Balance app icon")
						.width(140)

					Div {
						Div {
							H1("Balance")
								.class("large-title serif")

							P("Mindful time tracking")
								.class("title2 tertiary")
						}

						P("A time tracking app that helps you balance work and life.")
							.style("max-width: 15rem;")
					}
					.class("flex vertical center gap-s")
				}
				.class("flex vertical center gap-m")

				CTA()
			}
			.class("flex vertical center gap-xl")

			SwiftHtml.Main {
				SwiftHtml.Section {
					H2("Screenshots")
						.class("sr-only")

					Div {
						Img(src: Site.cdn + "/balance/landing-session.png", alt: "Balance clocked-in view")

						Div {
							Img(src: Site.cdn + "/balance/landing-menu-bar-app.png", alt: "Balance menu bar app")

							Img(src: Site.cdn + "/balance/landing-focus-timer.png", alt: "Balance focus timer")
						}

						Img(src: Site.cdn + "/balance/landing-log-summary.png", alt: "Balance log summary")
					}
					.class("balance-img-grid")
				}

				SwiftHtml.Section {
					Div {
						H2("Reviews")
							.class("title1 serif")

						P("Some kind words from the Balance community")
							.class("tertiary")
					}

					Div {
						RecognitionCard(title: "Absolutely amazing!", subtitle: "★★★★★ by mansara") {
							P("“Great visual design and delicate UX. It feels like I've got an assistant, who gently reminds me to start a session or get a break. Thank you!”")
						}

						RecognitionCard(title: "Great app", subtitle: "★★★★★ by Ashlee Peterson") {
							P("“I appreciate the clean UI and ease of use. To the point, helpful, and ad-free. My grandma could probably use this app (sorry nana).”")
						}

						RecognitionCard(title: "Gorgeous app", subtitle: "★★★★★ by feedthefishes") {
							P("“Adorable design, super simple and nice to use. Been looking for something like this quite a while. Thank you!”")
						}

						RecognitionCard(title: "The best way to focus your time", subtitle: "★★★★★ by Karlemilkoch") {
							P("Balance provides a gentle way to keep an eye on your current active work time and provides soft nudges, much like a friend would, to take a break from what you're currently doing.")
							P("I wouldn't be without Balance during my work days anymore.”")
						}

						RecognitionCard(title: "Amazing app and developer", subtitle: "★★★★★ by fall3n_j0ker") {
							P("“I use it daily and it really helps me to stay on top of actually taking breaks through the day.")
							P("The developer is very responsive and friendly. Worth every penny for Pro.”")
						}

						RecognitionCard(title: "Excellent", subtitle: "★★★★★ by Altair222") {
							P("“The app is spectacularly designed and made. The Pomodoro timer is perfect. The design of the Pomodoro timer is really good. The functionality in the Menu Bar item is spectacular. [...] Balance is a 6/5 app.”")
						}

						RecognitionCard(title: "Amazing app for students", subtitle: "★★★★★ by theiff") {
							P("“It is indespensible for students who study using the pomodoro method.”")
						}

						RecognitionCard(title: "Simple and elegant", subtitle: "★★★★★ by s.j.009") {
							P("“Its simple design is what makes it an amazing app for focus.”")
						}

						Input()
							.id("read-more-reviews")
							.class("more-checkbox")
							.type(.checkbox)

						Label("+ Read more reviews")
							.class("more-label")
							.for("read-more-reviews")

						RecognitionCard(title: "Great app for work awareness", subtitle: "★★★★★ by r i ch") {
							P("“Balance is superb at making you aware of how much you're working without being overbearing. It's very unintrusive, but finds ways to gently nudge you to remember to use it.")
							P("I've tried multiple time tracking apps, but this is the only one I've stuck to for more than a week.”")
						}

						RecognitionCard(title: "Beautifully designed, great to help with a work/life balance", subtitle: "★★★★★ by beckerkay") {
							P("“Balance is gorgeous in its design and has quickly become a part of my daily routine. The pro is definitely worth it - plus, supporting an independent app creator making this high quality of an app? Yes, please.")
							P("Balance has been especially fantastic for working while traveling. When I need to do work a bit more spread throughout the day, it reassures me I am being productive and getting a full day's work in, without guessing or winding up overworking.")
							P("Thanks for this incredible app, Alexander! Can't wait to see it grow even more!”")
						}

						RecognitionCard(title: "Loving Balance!", subtitle: "★★★★★ by 7b7003cf") {
							P("“It’s amazing how quickly Balance became a part of my daily workflow. Quickly tagging focus sessions, work times, and breaks has felt very natural, and the data on how I'm productively working allows me to structure work sessions to maximize efficiency.")
							P("Highly recommend Balance!!”")
						}

						RecognitionCard(title: "An absolute staple for work", subtitle: "★★★★★ by Alberto G. Pons") {
							P("“This app has been an absolute game changer for me.")
							P("As a work-from-home freelance, I use an app for time tracking in order to improve my efficiency and keep track of how much time I spend on each project/client - however, I was missing an app that would let me have deeper insight on my work days' schedule and that would help me separate work from life even when using the same computer.")
							P("Furthermore, it is intituive, beautifully designed and you can tell the developer really cares about it.”")
						}

						RecognitionCard(title: "Simple, well designed, effortless", subtitle: "★★★★★ by CaptnWarhol") {
							P("“I really just wanted a great pomodoro timer, which this is, but the little extras (clocking in/out, reminder notifications, etc) really just make it better at that.")
							P("It secretly wants to be a full-blown time tracking app and is good at that too, but at its core it just helps you focus and take breaks, and it excels at it.”")
						}

						RecognitionCard(title: "Great app!", subtitle: "★★★★★ by emirhando") {
							P("“The app is fantastic! Thanks for creating such a beautiful app. It deserves a great widget since Apple made widgets great again on Mac.”")
						}

						RecognitionCard(title: "A really nice time management app", subtitle: "★★★★★ by Louis 'LYRO' Dupont") {
							P("“A very simple app that does what it says perfectly. It will be a very useful pomodoro tool!”")
						}

						RecognitionCard(title: "Sick app, needs to be on mobile too", subtitle: "★★★★★ by Jack Winterburn") {
							P("“Balance is a great, sleek and unopinionated app to track work or study but for the sake of god we need a mobile port”")
						}

						RecognitionCard(title: "Off to a great start", subtitle: "★★★★★ by BankingBlues") {
							P("“I love this app and I'm looking forward to the iOS version. It's helping me to stay focused and gives me a great idea of how I'm spending my time throughout the week.")
							P("Keep going with this one, Alex!”")
						}

						RecognitionCard(title: "Special app, without being special", subtitle: "★★★★★ by QuakeboyX") {
							P("“Have seen many apps like this, but somehow this is better — right UI, notifications, the onboarding was great.”")
						}

						RecognitionCard(title: "Literally saving my back", subtitle: "★★★★★ by dotlouis") {
							P("“I initially downloaded Balance to remind me every hour or so to take a break and avoid another surgery due to sedentary lifestyle. I like how balance is “out of the way” yet pleasant to use.")
							P("If you read this: move more :)”")
						}
					}
					.class("balance-columns")
				}
				.class("v-gap-l center")

				SwiftHtml.Section {
					Div {
						H2("Recognition")
							.class("title1 serif")

						P("Selected awards and features")
							.class("tertiary")
					}

					Div {
						RecognitionCard(title: "Product Hunt — #1 Product of the Day (#3 Week)", subtitle: "December 27, 2022", href: "https://www.producthunt.com/posts/balance-855f20db-49ff-48ee-8096-6d33de52b71a")

						RecognitionCard(title: "Dense Discovery — Issue 231", subtitle: "March 27, 2023", href: "https://www.densediscovery.com/issues/231") {
							P("“This lovely-looking macOS app combines manual time tracking with regular break reminders and a built-in Pomodoro-style focus timer.”")
						}

						RecognitionCard(title: "The Manual #31 by Oliur", subtitle: "December 31, 2022", href: "https://oliur.substack.com/p/the-manual-31-end-of-year-learnings")

						RecognitionCard(title: "Creativerly 201 by Philipp Temmel", subtitle: "January 1, 2023", href: "https://creativerly.com/bust-writers-block/") {
							P("“There is always something special about opening up a new app you want to try out, and you immediately see all the craft and love for detail that went into designing its interface of it.")

							P("Balance sets an incredibly high standard for beautifully designed software.”")
						}

						RecognitionCard(title: "3 Best Pomodoro Timer Apps for Mac 2023", subtitle: "by Quinn Le", href: "https://www.youtube.com/watch?v=miBp1-p1mVI")

						RecognitionCard(title: "DEX 周刊 #172 by dingyi", subtitle: "January 3, 2023", href: "https://dex.zhubai.love/posts/2221955194135281664")

						RecognitionCard(title: "TechCrunch", subtitle: "December 27, 2022", href: "https://techcrunch.com/2022/12/27/balance-is-a-mac-timekeeper-app-that-requires-you-to-manually-clock-in-your-hours/") {
							P("“There are plenty of time-tracking apps for Mac that automatically log the hours you’ve spent signed in. Some even offer granular data, telling you how much time you spent on a particular app.")
							P("A new app called Balance is taking a slightly different approach to timekeeping, allowing users to manually punch in and punch out the time they are spending in front of a screen.”")
						}

						RecognitionCard(title: "8 productivity tools I cant live without in 2024", subtitle: "by kelly kim", href: "https://www.youtube.com/watch?v=rU3eZIl06p4") {
							P("“It makes a huge impact on my life. [...] Go check out Balance if you want to take proper breaks and track your time throughout the day.”")
						}

						RecognitionCard(title: "Department of Product", subtitle: "July 6, 2023", href: "https://departmentofproduct.substack.com/p/briefing-spotify-ceos-60m-body-scans")

						RecognitionCard(title: "i only speak liquid #25", subtitle: "May 24, 2023", href: "https://ionlyspeakliquid.beehiiv.com/p/speak-liquid-25-thinking-terms-sections-blocks") {
							P("“If you’re anything like me, you’ve gone through many different methods of tracking time. Balance is definitely one to look into.”")
						}
					}
					.class("balance-columns")
				}
				.class("v-gap-l center")

				Hr()

				Footer {
					Div {
						Div {
							Img(src: Site.cdn + "/balance/icon.png", alt: "Balance app icon")
								.width(100)

							CTA()
						}
						.class("flex vertical center gap-s")

						Div {
							A("Manual")
								.class("plain")
								.href("/balance/manual/")

							A("Support")
								.class("plain")
								.href("/apps/#support")

							A("Privacy")
								.class("plain")
								.href("/apps/#privacy")

							A("Terms")
								.class("plain")
								.href("/apps/#terms")
						}
						.class("footnote secondary flex center gap-m")
					}
					.class("flex vertical center gap-xl")

					Hr()

					Div {
						Div {
							Img(src: Site.cdn + "/alex.png", alt: "Alexander Sandberg")
								.width(40)
								.style("border-radius: 50%; filter: grayscale(1);")

							P(#"Balance is actively designed and developed by <a href="/">Alexander Sandberg</a>."#)
								.class("secondary")
								.style("max-width: 20rem;")
						}
						.class("flex vertical center gap-s")
					}
					.class("flex vertical center gap-l")
				}
				.class("flex vertical center gap-xxl")
			}
			.class("v-gap-xxl")
		}
		.class("v-gap-xxl")
	}
	.lang("en")
}

private struct CTA: TagRepresentable {
	func build() -> Tag {
		A("&ensp;Download")
			.href("https://apps.apple.com/app/id1637311725")
			.class("button plain")
	}
}
