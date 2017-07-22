//
//  ResponseErrorScheme.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 21/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation
import ObjectMapper

class ResponseErrorScheme: Mappable {
    var error: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        error <- map["Error"]
    }
}
