//
//  APIError.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 21/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation

enum APIError: Error {
    case httpError(error: HTTPError)
    case apiError(message: String)
    case internalError(message: String)
    case missingField(message: String)
    case unknownError
    
    var description: String {
        switch self {
            
        case .httpError(let error):
            return "Server error: \(error.description)"
        
        case .apiError(let message):
            return "API error: \(message)"

        case .internalError(let message):
            return "Internal API error: \(message)"
            
        case .missingField(let message):
            return "Missing required filed: \(message)"
            
        case .unknownError:
            return "Unknown error"
        }
    }
}
