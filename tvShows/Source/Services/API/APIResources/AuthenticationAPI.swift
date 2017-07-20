//
//  AuthenticationResource.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 20/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation

class AuthenticationAPI {
    
    let apiService = APIService.shared
    
    func login(apiKey: String,
               userKey: String?,
               userName: String?,
               success: @escaping (_ token: String) -> Void,
               failure: @escaping (APIError) -> Void) {
        
        var parameters: [String: Any] = [:]
        parameters["apikey"] = apiKey
        
        if let userKey = userKey {
            parameters["userkey"] = userKey
        }
        
        if let userName = userName {
            parameters["username"] = userName
        }
        
        let request = APIRequest(url: "/login", method: .post, parameters: parameters)
        
        apiService.send(request: request, scheme: TokenResponseScheme.self) { scheme, error in
            
            guard let scheme = scheme else {
                failure(error ?? .unknownError)
                return
            }
            
            guard let token = scheme.token else {
                failure(.missingField(message: "Token is absent"))
                return
            }
            
            success(token)
        }
    }
}
