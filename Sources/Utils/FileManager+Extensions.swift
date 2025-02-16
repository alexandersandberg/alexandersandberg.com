//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import Foundation

extension FileManager: @unchecked @retroactive Sendable {}

extension FileManager {
	func walkDirectory(at url: URL, options: DirectoryEnumerationOptions = [.skipsHiddenFiles, .skipsPackageDescendants]) -> AsyncStream<URL> {
		AsyncStream { continuation in
			Task {
				let enumerator = self.enumerator(at: url, includingPropertiesForKeys: nil, options: options)

				while let fileURL = enumerator?.nextObject() as? URL {
					if !fileURL.hasDirectoryPath {
						continuation.yield(fileURL)
					}
				}
				continuation.finish()
			}
		}
	}
}
