//
//  DataKeypathSchema.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 22/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation
import ObjectMapper

struct DataKeypathSchema<T: ImmutableMappable>: ImmutableMappable {
    
    var data: [T]
    
    init(map: Map) throws {
        data = try map.value("data")
    }
}
