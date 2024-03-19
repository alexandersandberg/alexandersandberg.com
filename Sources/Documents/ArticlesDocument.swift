//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

let articlesDocument = Document(.html) {
	Div {
		for articlePage in contentPages.articles {
			ArticleItem(page: articlePage)
		}
	}
	.class("v-gap-m")
}
