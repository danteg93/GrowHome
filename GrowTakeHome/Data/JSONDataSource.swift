//
//  JSONDataSource.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/22/24.
//

import Foundation

class JSONDataSource {
    
    enum JSONDataSourceError: Error {
        case fileNotFound
        case failedToLoad
    }
    
    static func load(fileName: String) throws -> Data {
        guard let file = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            throw JSONDataSourceError.fileNotFound
        }
        do {
            let data = try Data(contentsOf: file)
            return data
        } catch {
            throw JSONDataSourceError.failedToLoad
        }
    }
}
