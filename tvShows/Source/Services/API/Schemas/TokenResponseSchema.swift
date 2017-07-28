//
//  TokenResponseSchema.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 21/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation
import ObjectMapper

struct TokenResponseSchema: ImmutableMappable {
    var token: String
    
    init(map: Map) throws {
        token = try map.value("token")
    }
}
