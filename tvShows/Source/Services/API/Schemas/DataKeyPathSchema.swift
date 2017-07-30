//
//  DataKeypathSchema.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 22/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation
import ObjectMapper

struct DataKeyPathSchema<T: ImmutableMappable>: ImmutableMappable {
    
    var data: T
    var errors: Errors?
    
    init(map: Map) throws {
        data = try map.value("data")
        errors = try? map.value("errors")
    }
}
