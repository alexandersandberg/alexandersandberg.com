//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

// TODO: add more meta stuff
struct SiteHead: TagRepresentable {
	var title: String

	func build() -> Tag {
		Head {
			Meta().charset("utf-8")
			Meta().name(.viewport).content("width=device-width, initial-scale=1, viewport-fit=cover")
			Title(title)
			Link(rel: .stylesheet).href("/assets/styles.css")
		}
	}
}
