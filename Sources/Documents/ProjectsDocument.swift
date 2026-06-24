//
//  File.swift
//
//
//  Created by Alexander Sandberg on 22.03.24.
//

import SwiftHtml

let projectsDocument = Document(.html) {
	Section(title: "Apps", moreLink: .apps("Details")) {
		Grid(columns: .c2, spacing: .s32) {
			for resource in Projects.apps {
				LinkedResourceItem(resource: resource)
			}
		}
	}

	Hr()

	Section(title: "Personal") {
		Grid(columns: .c2, spacing: .s32) {
			for resource in Projects.personal {
				LinkedResourceItem(resource: resource)
			}
		}
	}

	Hr()

	Section(title: "Other") {
		Grid(columns: .c2, spacing: .s32) {
			for resource in Projects.other {
				LinkedResourceItem(resource: resource)
			}
		}
	}
}
