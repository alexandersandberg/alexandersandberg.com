//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 26.03.24.
//

import SwiftHtml

let balanceDocument = Document(.html) {
	P {
		Span("WIP...")

		A("Owner’s Manual")
			.href("/balance/manual")
	}
}
