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
               success: @escaping () -> Void,
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
        
        apiService.send(request: request, schema: TokenResponseSchema.self) { schema, error in
            
            guard let schema = schema else {
                failure(error ?? .unknownError)
                return
            }
            
            guard let token = schema.token else {
                failure(.missingField(message: "Token is absent"))
                return
            }
            
            self.apiService.authToken = token
            success()
        }
    }
}
