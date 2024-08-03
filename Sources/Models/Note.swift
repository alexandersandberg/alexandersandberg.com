//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 03.08.24.
//

import Foundation

struct Note: Codable, Identifiable {
	var id: Int
	var markdown: String
	var contentHtmlString: String
	var publishedAt: Date

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(Int.self, forKey: .id)
		self.markdown = try container.decode(String.self, forKey: .markdown)
		self.contentHtmlString = ""

		let dateFormat = "yyyy-MM-dd"
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = dateFormat

		let publishedAtString = try container.decode(String.self, forKey: .publishedAt)
		self.publishedAt = dateFormatter.date(from: publishedAtString)!
	}
}

extension Note: Comparable {
	static func < (lhs: Note, rhs: Note) -> Bool {
		lhs.id < rhs.id
	}
}
