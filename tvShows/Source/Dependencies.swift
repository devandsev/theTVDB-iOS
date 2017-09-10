//
//  Dependencies.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 22/08/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation

struct AppDependencies: HasConfigService, HasAPI, HasSessionService, HasApiService, HasLoggerService, HasHTTPService {
    
    let configService: ConfigService
    let sessionService: SessionService
    let apiService: APIService
    let api: API
    let loggerService: LoggerService
    let httpService: HTTPService
    
    func resolveInternalDependencies() {
        sessionService.di = self
        apiService.di = self
        httpService.di = self
        
        api.di = self
        api.configure()
    }
}

class DI {
    
    static let appDependencies: AppDependencies = {
        
        let d = AppDependencies(configService: ConfigService(),
                                sessionService: SessionService(),
                                apiService: APIService(),
                                api: API(),
                                loggerService: LoggerService(),
                                httpService: HTTPService())
        
        d.resolveInternalDependencies()
        
        return d
    }()
}

protocol HasDependencies: class {
    associatedtype Dependencies
    
    var di: Dependencies! { get set }
}
