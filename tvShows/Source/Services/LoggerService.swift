//
//  LoggerService.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 22/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation

class LoggerService {
    
    enum RequestDetalization {
        case short
        case detailed
    }
    
    enum ResponseDetalization {
        case short
        case detailed
    }
    
    static let shared = LoggerService()
    
    var isEnabled = true
    
    var requestDetalization: RequestDetalization = .detailed
    var responseDetalization: ResponseDetalization = .detailed
    
    func log(error: APIError) {
        guard isEnabled else {
            return
        }
        
        print("🔴" + error.detailedDescription)
    }
    
    func log(error: HTTPError) {
        guard isEnabled else {
            return
        }
        
        print("🔴" + error.description)
    }
    
    func log(response: HTTPURLResponse, responseJSON: HTTPJSON) {
        guard isEnabled else {
            return
        }
        
        let url: String = response.url?.absoluteString ?? ""
        
        switch self.responseDetalization {
            
        case .detailed:
            print("⤵️\(url)\n\(responseJSON)")
            
        case .short:
            print("⤵️\(url) ...")
        }
        
        print("⏹\n")
    }

    func logRequest(url: String, method: HTTPService.HTTPMethod, parameters: [String: Any]) {
        guard isEnabled else {
            return
        }
        
        switch self.requestDetalization {
            
        case .detailed:
            print("⤴️\(method.rawValue) \(url)\n\(parameters)")
            
        case .short:
            print("⤴️\(method.rawValue) \(url) ...")
        }
        
        print("⏹\n")
    }
}
