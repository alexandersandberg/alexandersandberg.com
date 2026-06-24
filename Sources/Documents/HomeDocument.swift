//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

let homeDocument = Document(.html) {
	Html {
		SiteHead(description: Site.bio.strippedOfHtmlTags, canonicalHref: Site.url + "/")

		Body {
			VStack(alignment: .stretch, spacing: .s48) {
				SiteHeader(supertitle: "The Garden of", title: "Alexander Sandberg")

				SwiftHtml.Main {
					VStack(alignment: .stretch, spacing: .s48) {
						BioSection()

						Hr()

						ProjectsSection()

						Hr()

						NotesSection()

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

private struct ProjectsSection: TagRepresentable {
	func build() -> Tag {
		Section(title: "Projects", moreLink: .projects("Show all")) {
			Grid(columns: .c2, spacing: .s32) {
				for resource in Projects.all where resource.isFeatured {
					LinkedResourceItem(resource: resource)
				}
			}
		}
	}
}

private struct NotesSection: TagRepresentable {
	func build() -> Tag {
		Section(title: "Notes", moreLink: .notes("Archive")) {
			VStack(alignment: .leading, spacing: .s48) {
				for note in notes.sorted(by: >).prefix(3) {
					NoteItem(note: note)
				}
			}
		}
	}
}

private struct ArticlesSection: TagRepresentable {
	func build() -> Tag {
		Section(title: "Articles", moreLink: .articles("Archive")) {
			VStack(alignment: .leading, spacing: .s32) {
				for page in articles.sorted(by: >).prefix(5) {
					ArticleItem(page: page)
				}
			}
		}
	}
}
