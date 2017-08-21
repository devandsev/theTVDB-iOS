//
//  APIRequest.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 20/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation

struct APIRequest {
    
    let url: String
    let method: HTTPService.HTTPMethod
    let parameters: [String: Any]
    
    var retriesLeft: Int = 1
    
    init(url: String, method: HTTPService.HTTPMethod, parameters: [String: Any]) {
        
        self.url = url
        self.method = method
        self.parameters = parameters
    }
}
