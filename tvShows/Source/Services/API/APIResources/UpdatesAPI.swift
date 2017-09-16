//
//  UpdatesAPI.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 16/09/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation
import ObjectMapper

class UpdatesAPI: HasDependencies {
    
    typealias Dependencies = HasApiService
    var di: Dependencies!
    
    let endpoint = "/updated"
    
    func updatedSince(date: Date,
                      success: @escaping (Series) -> Void,
                      failure: @escaping (APIError) -> Void) {
        
        let params: [String: Any]
        params = ["fromTime": Int(date.timeIntervalSince1970)]
        
        let request = APIRequest(url: endpoint + "/query", method: .get, parameters: params)
        
        self.di.apiService.send(request: request, schema: DataKeyPathSchema<Series>.self) { schema, error in
            
            guard let series = schema?.data else {
                failure(error ?? .unknownError)
                return
            }
            
            success(series)
        }
    }
}

