//
//  SearchAPI.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 21/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchAPI: HasDependencies {
    
    typealias Dependencies = HasApiService
    var di: Dependencies!
    
    let endpoint = "/search/series"
    
    func search(name: String,
                success: @escaping ([Series]) -> Void,
                failure: @escaping (APIError) -> Void) {
        
        var parameters: [String: Any] = [:]
        parameters["name"] = name
        
        let request = APIRequest(url: endpoint, method: .get, parameters: parameters)
        
        self.di.apiService.send(request: request, schema: DataArrayKeypathSchema<Series>.self) { schema, error in
            
            guard let series = schema?.data else {
                failure(error ?? .unknownError)
                return
            }
            
            success(series)
        }
    }
}
