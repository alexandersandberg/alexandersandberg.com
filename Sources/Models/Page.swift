//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import Foundation
import SwiftHtml

struct Page {
	var path: String
	var layout: Layout?
	var publishedAt: Date?
	var updatedAt: Date?
	var htmlContentString: String

	var htmlString: String {
		if let layout {
			layout.htmlString.replacing("<\(Content().name)>", with: htmlContentString)
		} else {
			htmlContentString
		}
	}

	var relativePath: String {
		"/" + path
	}
}
