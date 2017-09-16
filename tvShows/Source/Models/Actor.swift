//
//  Actor.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 16/09/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation
import ObjectMapper

struct Actor: ImmutableMappable {
    
    let id: Int
    let image: String
    let imageAdded: Date
    let imageAuthorId: Int
    let lastUpdated: Date
    let name: String
    let role: String
    let seriesId: Int
    let sortOrder: Int
    
    init(map: Map) throws {
        id = try map.value("id")
        image = try map.value("image")
        imageAdded = try map.value("imageAdded", using: PlainDateTransform())
        imageAuthorId = try map.value("imageAuthor")
        lastUpdated = try map.value("lastUpdated", using: PlainDateTransform())
        name = try map.value("name")
        role = try map.value("role")
        seriesId = try map.value("seriesId")
        sortOrder = try map.value("sortOrder")
    }
}
