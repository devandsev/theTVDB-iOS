//
//  Dependencies.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 22/08/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation

struct AppDependencies: HasConfigService, HasAPI, HasSessionService {
    
    let configService: ConfigService
    let sessionService: SessionService
    let api: API
}

class DI {
    
    static let appDependencies: AppDependencies = {
        
        return
        AppDependencies(configService: ConfigService(),
                        sessionService: SessionService(),
                        api: API())
    }()
    
//    static func configure<T: HasDependencies>(object: T) {
//
//    // `as?` fucks up dependencies
//        guard let di = DI.appDependencies as? T.Dependencies else {
//            return
//        }
//        
//        object.di = di
//    }
}

protocol HasDependencies: class {
    associatedtype Dependencies
    
    var di: Dependencies! { get set }
}
