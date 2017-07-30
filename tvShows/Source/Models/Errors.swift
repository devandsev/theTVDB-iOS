//
//  Errors.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 24/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation
import ObjectMapper

struct Errors: ImmutableMappable {
    
    var invalidFilters: [String]?
    var invalidLanguage: String?
    var invalidQueryParams: [String]?
    
    init(map: Map) throws {
        invalidFilters = try? map.value("invalidFilters")
        invalidLanguage = try? map.value("invalidLanguage")
        invalidQueryParams = try map.value("invalidQueryParams")
    }
}
