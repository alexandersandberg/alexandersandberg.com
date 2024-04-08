//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 08.04.24.
//

import Foundation

extension Date {
	var dayMonthYear: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		dateFormatter.timeStyle = .none
		dateFormatter.locale = Locale(identifier: "en_US")

		return dateFormatter.string(from: self)
	}
}
