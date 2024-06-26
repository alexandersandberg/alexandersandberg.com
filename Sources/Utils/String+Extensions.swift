//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import Foundation
import Crypto

extension String: LocalizedError {
	public var errorDescription: String? { return self }

	var slug: String {
		self
			.replacingOccurrences(of: " ", with: "-")
			.lowercased()
	}

	var isValidSlug: Bool {
		do {
			let regex = try NSRegularExpression(pattern: "^[a-z0-9]+(-[a-z0-9]+)*$")
			return regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.utf16.count)) != nil
		} catch {
			return false
		}
	}

	var strippedOfHtmlTags: String {
		replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
	}

	var md5Hash: String {
		Insecure.MD5.hash(data: self.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
	}

	var withConvertedExternalLinks: String {
		let pattern = "(<a [^>]*?href=[\"'](http[^\"']*?)[\"'])([^>]*>)(.*?)(</a>)"
		let template = "$1 target=\"_blank\"$3$4$5" + ExternalLinkArrow.htmlString

		let regex = try! NSRegularExpression(pattern: pattern, options: [])
		let range = NSRange(location: 0, length: self.utf16.count)

		return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: template)
	}

	func writeToOutputDirectory(path: String, prettyURL: Bool) throws {
		let url = outputDirectory.appendingPathComponent(path)

		let directory = prettyURL ? url : url.deletingLastPathComponent()
		if !fileManager.fileExists(atPath: directory.path) {
			try fileManager.createDirectory(at: directory, withIntermediateDirectories: true)
		}

		let file = if prettyURL {
			url.appendingPathComponent("index.html")
		} else if !url.lastPathComponent.contains(".") {
			url.appendingPathExtension("html")
		} else {
			url
		}

		try self.write(to: file, atomically: true, encoding: .utf8)
	}
}
