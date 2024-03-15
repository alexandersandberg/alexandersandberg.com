//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import Foundation

extension URL {
	var withoutRootPath: URL {
		URL(string: self.relativePath.replacingOccurrences(of: rootPath, with: ""))!
	}
}
