//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import Foundation

extension String: LocalizedError {
	public var errorDescription: String? { return self }

	var isValidSlug: Bool {
		do {
			let regex = try NSRegularExpression(pattern: "^[a-z0-9]+(-[a-z0-9]+)*$")
			return regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.utf16.count)) != nil
		} catch {
			return false
		}
	}

	func writeToOutputDirectory(path: String) throws {
		let url = outputDirectory.appending(path: path)

		if !fileManager.fileExists(atPath: url.path) {
			try fileManager.createDirectory(at: url, withIntermediateDirectories: true)
		}

		let file = url.appending(path: "index.html")
		try self.write(to: file, atomically: true, encoding: .utf8)
	}
}
