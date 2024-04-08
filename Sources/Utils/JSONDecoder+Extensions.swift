//
//  File.swift
//  
//
//  Created by Alexander Sandberg on 24.03.24.
//

import Foundation

extension JSONDecoder {
	func decode<T: Decodable>(_ type: T.Type, from fileName: String) -> T where T: Decodable {
		guard let url = Bundle.module.url(forResource: fileName, withExtension: nil) else {
			fatalError("Failed to locate \(fileName).")
		}

		guard let data = try? Data(contentsOf: url) else {
			fatalError("Failed to load \(fileName).")
		}

		do {
			return try self.decode(T.self, from: data)
		} catch {
			switch error {
			case let DecodingError.keyNotFound(_, context),
				let DecodingError.typeMismatch(_, context),
				let DecodingError.valueNotFound(_, context):
				fatalError(context.debugDescription)
			default:
				fatalError("Failed to decode \(fileName)")
			}
		}
	}
}
