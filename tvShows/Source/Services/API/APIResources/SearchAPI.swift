//
//  SearchAPI.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 21/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchAPI {
    
    let apiService = APIService.shared
    
    func search(name: String,
                success: @escaping ([Series]) -> Void,
                failure: @escaping (APIError) -> Void) {
        
        var parameters: [String: Any] = [:]
        parameters["name"] = name
        
        let request = APIRequest(url: "/search/series", method: .get, parameters: parameters)
        
        apiService.send(request: request, schema: DataKeypathSchema<Series>.self) { schema, error in
            
            guard let series = schema?.data else {
                failure(error ?? .unknownError)
                return
            }
            
            success(series)
        }
    }
}
