//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 24.03.24.
//

import SwiftRss

open class AtomLink: Tag {
	open override class func createNode() -> Node {
		Node(type: .standard, name: "atom:link")
	}
}
