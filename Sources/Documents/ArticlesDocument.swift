//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

let articlesDocument = Document(.html) {
	Section(title: "Articles", contentClass: "v-gap-m") {
		for articlePage in contentPages.articles {
			ArticleItem(page: articlePage)
		}
	}
}
