//
//  TokenResponseScheme.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 21/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation
import ObjectMapper

var base: String?

class TokenResponseScheme: Mappable {
    var token: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        token <- map["token"]
    }
}
