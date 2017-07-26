//
//  Series.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 22/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation
import ObjectMapper

class Series: Mappable {
    
    var id: Int?
    var aliases: [String]?
    var banner: String?
    var firstAired: String?
    var network: String?
    var overview: String?
    var name: String?
    var status: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        aliases <- map["aliases"]
        banner <- map["banner"]
        firstAired <- map["firstAired"]
        network <- map["network"]
        overview <- map["overview"]
        name <- map["seriesName"]
        status <- map["status"]
    }
}
