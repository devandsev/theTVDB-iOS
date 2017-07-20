//
//  HTTPError.swift
//  perfectReads
//
//  Created by Andrey Sevrikov on 20/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation

enum HTTPError: Error {
    case serverError(message: String, code: Int)
    case connectionError(message: String)
    case parserError(message: String)
    case internalError(message: String)
    
    var description: String {
        switch self {
            
        case .serverError(let message, _):
            return "Server error: \(message)"
            
        case .connectionError(let message):
            return "Connection error: \(message)"
            
        case .parserError(let message):
            return "Parser error: \(message)"
            
        case .internalError(let message):
            return "Internal error: \(message)"
        }
    }
}
