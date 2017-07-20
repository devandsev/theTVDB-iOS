//
//  APIService.swift
//  Services
//
//  Created by Andrey Sevrikov on 10/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation
import ObjectMapper

class APIService {
    
    static let shared: APIService = APIService()
    
    private let httpService = HTTPService.shared
    
    let baseUrl: String = "https://api.thetvdb.com"
    let authToken: String? = ""
    
    func send<T>(request: APIRequest, scheme: T.Type, completion: @escaping (T?, APIError?) -> Void) where T: Mappable {
        
        let fullUrl = baseUrl + request.url
        httpService.request(url: fullUrl, method: request.method, parameters: request.parameters) { result in
            
            switch result {
                
            case .failure(let error):
                completion(nil, .httpError(error: error))
                
            case .success(let json, let code):
                switch json {
                    
                case .dictionary(let json):
                    guard let object = Mapper<T>().map(JSON: json) else {
                        completion(nil, .internalError(message: "API: Couldn't map JSON to an object"))
                        return
                    }
                    completion(object, nil)
                    
                case .array(let json):
                    completion(nil, .internalError(message: "API: Expected dictionary, but got an array"))
                }
            }
        }
    }
    
    func send<T>(request: APIRequest, arrayOf: T.Type, completion: @escaping ([T], APIError?) -> Void) where T: Mappable {
        
        let fullUrl = baseUrl + request.url
        httpService.request(url: fullUrl, method: request.method, parameters: request.parameters) { result in
            
            switch result {
                
            case .failure(let error):
                completion([], .httpError(error: error))
                
            case .success(let json, let code):
                switch json {
                    
                case .dictionary(let json):
                    completion([], .internalError(message: "API: Expected array, but got a dictionary"))
                    
                case .array(let json):
                    
                    guard let json = json as? [[String: Any]] else {
                        completion([], .internalError(message: "API: Incorrect JSON structure"))
                        return
                    }
                    
                    let array = Mapper<T>().mapArray(JSONArray: json)
                    completion(array, nil)
                }
            }
        }
    }
}
