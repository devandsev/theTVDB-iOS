//
//  SessionService.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 21/08/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation
import KeychainAccess

protocol HasSessionService {
    var sessionService: SessionService { get }
}

class SessionService: HasDependencies {
    
    typealias Dependencies = HasApiService & HasConfigService & HasAPI
    var di: Dependencies!
    
    private let keychain = Keychain(service: KeychainKeys.keychainService)
    
    private struct KeychainKeys {
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
        
        self.di.apiService.authToken = authToken
        success()
    }
    
    func reset(success: @escaping () -> Void,
               failure: @escaping (APIError) -> Void) {
        
        self.di.api.authentication.login(apiKey: self.di.configService.apiKey, userKey: nil, userName: nil, success: { token in
            self.keychain[KeychainKeys.authToken] = token
            self.di.apiService.authToken = token
            success()
        }) { error in
            failure(error)
        }
    }
    
    func updateIfNeeded(error: APIError,
                        success: @escaping () -> Void,
                        failure: @escaping (APIError) -> Void) {
        
        guard case let APIError.httpError(httpError) = error,
        case let HTTPError.serverError(_, code) = httpError,
        code == 401 else {
            failure(error)
            return
        }
        
        self.reset(success: { 
            success()
        }) { error in
            failure(error)
        }
    }
}
