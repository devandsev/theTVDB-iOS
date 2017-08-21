//
//  SessionService.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 21/08/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation
import KeychainAccess

class SessionService {
    
    static let shared: SessionService = SessionService()
    
    let config = ConfigService.shared
    let authenticationAPI = AuthenticationAPI()
    let apiService = APIService.shared
    
    let keychain = Keychain(service: KeychainKeys.keychainService)
    
    struct KeychainKeys {
        static let keychainService = "tvShows.keychain"
        static let authToken = "session.authToken"
    }
    
    func restore(success: @escaping () -> Void,
                 failure: @escaping (APIError) -> Void) {
        
        guard let authToken = keychain[KeychainKeys.authToken] else {
            self.reset(success: { 
                success()
            }, failure: { error in
                failure(error)
            })
            
            return
        }
        
        self.apiService.authToken = authToken
        success()
    }
    
    func reset(success: @escaping () -> Void,
               failure: @escaping (APIError) -> Void) {
        
        authenticationAPI.login(apiKey: config.apiKey, userKey: nil, userName: nil, success: { token in
            self.keychain[KeychainKeys.authToken] = token
            self.apiService.authToken = token
            success()
        }) { error in
            failure(error)
        }
    }
}
