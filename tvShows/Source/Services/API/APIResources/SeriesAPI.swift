//
//  SeriesAPI.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 22/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation
import ObjectMapper

class SeriesAPI {
    
    let apiService = APIService.shared
    
    func series(id: Int,
                success: @escaping (Series) -> Void,
                failure: @escaping (APIError) -> Void) {
        
        var parameters: [String: Any] = [:]
        
        let request = APIRequest(url: "/series/\(id)", method: .get, parameters: parameters)
        
        apiService.send(request: request, schema: DataKeyPathSchema<Series>.self) { schema, error in
            
            guard let series = schema?.data else {
                failure(error ?? .unknownError)
                return
            }
            
            success(series)
        }
    }
}
