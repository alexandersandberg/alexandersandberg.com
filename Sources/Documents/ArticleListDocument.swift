//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

let articleListDocument = Document(.html) {
	Div {
		for articlePage in contentPages.articles.sorted(by: >) {
			ArticleItem(page: articlePage)
		}
	}
	.class("v-gap-m")
}
