//
//  SeriesAPI.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 22/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation
import ObjectMapper

class SeriesAPI: HasDependencies {
    
    typealias Dependencies = HasApiService
    var di: Dependencies!
    
    let endpoint = "/series"
    
    func series(id: Int,
                success: @escaping (Series) -> Void,
                failure: @escaping (APIError) -> Void) {
        
        let request = APIRequest(url: endpoint + "/\(id)", method: .get, parameters: [:])
        
        self.di.apiService.send(request: request, schema: DataKeyPathSchema<Series>.self) { schema, error in
            
            guard let series = schema?.data else {
                failure(error ?? .unknownError)
                return
            }
            
            success(series)
        }
    }
    
    func actors(seriesId: Int,
                success: @escaping ([Actor]) -> Void,
                failure: @escaping (APIError) -> Void) {
        
        let request = APIRequest(url: endpoint + "/\(seriesId)" + "/actors", method: .get, parameters: [:])
        
        self.di.apiService.send(request: request, schema: DataArrayKeypathSchema<Actor>.self) { schema, error in
            
            guard let actors = schema?.data else {
                failure(error ?? .unknownError)
                return
            }
            
            success(actors)
        }
    }
}
