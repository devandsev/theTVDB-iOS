//
//  API.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 22/08/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation

protocol HasAPI {
    var api: API { get }
}

class API {
    
    let authentication = AuthenticationAPI()
    let search = SearchAPI()
    let series = SeriesAPI()
}
