//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import SwiftHtml

let aboutDocument = Document(.html) {
	Section(title: "Who", contentClass: "prose") {
		P("The all-or-nothing aspect of startups was <b>not something we wanted</b>. Viaweb's hackers were all extremely risk-averse. If there had been some way just to work super hard and get paid for it, without having a lottery mixed in, we would have been delighted.")
	}

	Section(title: "What", contentClass: "prose") {
		P("We would have much preferred a 100% chance of $1 million to a 20% chance of $10 million, even though theoretically the second is worth twice as much.")
	}

	Section(title: "Why", contentClass: "prose") {
		P("Unfortunately, there is not currently any <code>space</code> in the business world where you can get the first deal.")
	}
}
