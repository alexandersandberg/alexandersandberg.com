//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 15.03.24.
//

import Foundation
import Crypto

extension String: @retroactive LocalizedError {
	public var errorDescription: String? { return self }
}

extension String {
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

	var withLinkSuffixes: String {
		let linkPattern = "(<a [^>]*?href=[\"']([^\"']*?)[\"'])([^>]*>)(.*?)(</a>)"

		let linkRegex = try! NSRegularExpression(pattern: linkPattern, options: [])
		let range = NSRange(location: 0, length: self.utf16.count)

		let matches = linkRegex.matches(in: self, options: [], range: range)

		var result = self

		for match in matches.reversed() {
			let linkRange = match.range(at: 0)
			let urlRange = match.range(at: 2)

			let linkString = (self as NSString).substring(with: linkRange)
			let urlString = (self as NSString).substring(with: urlRange)

			var convertedLinkString = linkString

			if urlString.hasPrefix("http") {
				convertedLinkString = convertedLinkString.replacingOccurrences(of: ">", with: " target=\"_blank\">")
				convertedLinkString += ExternalLinkSuffix.htmlString
			} else if urlString.hasPrefix("mailto:") {
				convertedLinkString += MailtoLinkSuffix.htmlString
			}

			result = (result as NSString).replacingCharacters(in: linkRange, with: convertedLinkString)
		}

		return result
	}

	var withVideoElements: String {
		let imgPattern = "(<img [^>]*?src=[\"']([^\"']*?)[\"'])([^>]*?alt=[\"']([^\"']*?)[\"'])([^>]*>)"

		let imgRegex = try! NSRegularExpression(pattern: imgPattern, options: [])
		let range = NSRange(location: 0, length: self.utf16.count)

		let matches = imgRegex.matches(in: self, options: [], range: range)

		var result = self

		for match in matches.reversed() {
			let imgRange = match.range(at: 0)
			let srcRange = match.range(at: 2)
			let altRange = match.range(at: 4)

			let imgString = (self as NSString).substring(with: imgRange)
			let srcString = (self as NSString).substring(with: srcRange)
			let altString = (self as NSString).substring(with: altRange)

			var convertedElementString = imgString

			if srcString.hasSuffix(".mp4") {
				convertedElementString = "<video controls autoplay loop aria-label='\(altString)'><source src='\(srcString)' type='video/\(srcString.split(separator: ".").last!)'></video>"
			}

			result = (result as NSString).replacingCharacters(in: imgRange, with: convertedElementString)
		}

		return result
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
