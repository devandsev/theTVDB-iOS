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

class API: HasDependencies {
    
    typealias Dependencies = HasApiService
    var di: Dependencies!
    
    let authentication = AuthenticationAPI()
    let search = SearchAPI()
    let series = SeriesAPI()
    let updates = UpdatesAPI()
    
    func configure() {
        authentication.di = di
        search.di = di
        series.di = di
        updates.di = di
    }
}
