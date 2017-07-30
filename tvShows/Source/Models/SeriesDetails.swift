//
//  SeriesDetails.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 24/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation
import ObjectMapper

struct SeriesDetails: ImmutableMappable {
    
    var added: String
    var addedBy: String?
    var airsDayOfWeek: String
    var airsTime: String
    var genre: [String]
    var imdbId: String
    var lastUpdated: Date
    var networkId: String
    var rating: String
    var runtime: String
    var seriesId: String
    var siteRating: Float
    var siteRatingCount: Int
    var zap2itId: String
    
    init(map: Map) throws {
        added = try map.value("added")
        addedBy = try? map.value("addedBy")
        airsDayOfWeek = try map.value("airsDayOfWeek")
        airsTime = try map.value("airsTime")
        genre = try map.value("genre")
        imdbId = try map.value("imdbId")
//        lastUpdated = try map.value("lastUpdated")
        lastUpdated = try map.value("lastUpdated", nested: nil, delimiter: "", using: DateTransform())
//        birthday <- (map["birthday"], DateTransform())
        networkId = try map.value("networkId")
        rating = try map.value("rating")
        runtime = try map.value("runtime")
        seriesId = try map.value("seriesId")
        siteRating = try map.value("siteRating")
        siteRatingCount = try map.value("siteRatingCount")
        zap2itId = try map.value("zap2itId")
    }
}
