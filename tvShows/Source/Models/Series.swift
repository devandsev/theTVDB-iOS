//
//  Series.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 22/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation
import ObjectMapper

struct Series: ImmutableMappable {
    
    // in response for /search
    var id: Int
    var aliases: [String]
    var banner: String
    var firstAired: String
    var network: String
    var overview: String
    var name: String
    var status: String
    
    var details: SeriesDetails?
   
    init(map: Map) throws {
        id = try map.value("id")
        aliases = try map.value("aliases")
        banner = try map.value("banner")
        firstAired = try map.value("firstAired")
        network = try map.value("network")
        overview = (try? map.value("overview")) ?? ""
        name = (try? map.value("seriesName")) ?? ""
        status = try map.value("status")
        
        details = try? SeriesDetails(map: map)
    }
}
