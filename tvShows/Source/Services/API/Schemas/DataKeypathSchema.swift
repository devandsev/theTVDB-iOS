//
//  DataKeypathSchema.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 22/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation
import ObjectMapper

class DataKeypathSchema<T: Mappable>: Mappable {
    
    var data: [T]?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}
