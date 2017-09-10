//
//  ConfigService.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 21/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation

protocol HasConfigService {
    var configService: ConfigService { get }
}

class ConfigService {
    
    var apiKey: String = {
        guard let path = Bundle.main.path(forResource: "keys_private", ofType: "plist"),
            let dic = NSDictionary(contentsOfFile: path) as? [String: AnyObject],
            let value = dic["apiKey"] as? String else {
                return ""
        }
        
        return value
    }()
}
