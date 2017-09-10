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
    
    func series(id: Int,
                success: @escaping (Series) -> Void,
                failure: @escaping (APIError) -> Void) {
        
        let request = APIRequest(url: "/series/\(id)", method: .get, parameters: [:])
        
        self.di.apiService.send(request: request, schema: DataKeyPathSchema<Series>.self) { schema, error in
            
            guard let series = schema?.data else {
                failure(error ?? .unknownError)
                return
            }
            
            success(series)
        }
    }
}
