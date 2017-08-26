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
    private let logger = LoggerService.shared
    
    let baseUrl: String = "https://api.thetvdb.com"
    
    var authToken: String? {
        didSet {
            guard let authToken = authToken,
            !authToken.isEmpty else {
                httpService.headers.removeValue(forKey: "Authorization")
                return
            }
            httpService.headers["Authorization"] = "Bearer \(authToken)"
        }
    }
    
    // MARK: - Public
    
    func send<T>(request: APIRequest, schema: T.Type, completion: @escaping (T?, APIError?) -> Void) where T: ImmutableMappable {
        
        let fullUrl = baseUrl + request.url
        httpService.request(url: fullUrl, method: request.method, parameters: request.parameters) { result in
            
            if let serializedError = self.error(from: result) {
                
                let failure: (APIError) -> Void = { error in
                    self.logger.log(error: error)
                    completion(nil, error)
                }
                
                guard request.retriesLeft > 0 else {
                    failure(serializedError)
                    return
                }
                
                SessionService.shared.updateIfNeeded(error: serializedError, success: {
                    self.send(request: request, schema: schema, completion: completion)
                }, failure: { error in
                    failure(serializedError)
                })
                
                return
            }
            
            switch result {
                
            case .failure(let error):
                self.logger.log(error: error)
                completion(nil, .httpError(error: error))
                
            case .success(let json, let code):
                let (possibleJson, formatError) = self.checkThatItsDictionary(json: json)
                
                guard let dicJson = possibleJson else {
                    self.logger.log(error: formatError)
                    completion(nil, formatError)
                    return
                }
                
                do {
                    let object = try Mapper<T>().map(JSON: dicJson)
                    completion(object, nil)
                } catch let error as MapError {
                    let apiError: APIError = .internalError(message: "API: ObjectMapper error: \(error.description)")
                    self.logger.log(error: apiError)
                    completion(nil, apiError)
                } catch {
                    let apiError: APIError = .internalError(message: "API: Couldn't map JSON to an object")
                    self.logger.log(error: apiError)
                    completion(nil, apiError)
                }
            }
        }
    }
    
    func send<T>(request: APIRequest, arrayOf: T.Type, completion: @escaping ([T], APIError?) -> Void) where T: ImmutableMappable {
        
        let fullUrl = baseUrl + request.url
        httpService.request(url: fullUrl, method: request.method, parameters: request.parameters) { result in
            
            if let serializedError = self.error(from: result) {

                let failure: (APIError) -> Void = { error in
                    self.logger.log(error: error)
                    completion([], error)
                }
                
                guard request.retriesLeft > 0 else {
                    failure(serializedError)
                    return
                }
                
                SessionService.shared.updateIfNeeded(error: serializedError, success: {
                    self.send(request: request, arrayOf: arrayOf, completion: completion)
                }, failure: { error in
                    failure(serializedError)
                })
                
                return
            }
            
            switch result {
                
            case .failure(let error):
                self.logger.log(error: error)
                completion([], .httpError(error: error))
                
            case .success(let json, let code):
                let (possibleJson, formatError) = self.checkThatItsArray(json: json)
                
                guard let arrJson = possibleJson else {
                    self.logger.log(error: formatError)
                    completion([], formatError)
                    return
                }
                
                guard let json = arrJson as? [[String: Any]] else {
                    let apiError: APIError = .internalError(message: "API: Incorrect JSON structure")
                    self.logger.log(error: apiError)
                    completion([], apiError)
                    return
                }
                
                do {
                    let array = try Mapper<T>().mapArray(JSONArray: json)
                    completion(array, nil)
                } catch let error as MapError {
                    let apiError: APIError = .internalError(message: "API: ObjectMapper error: \(error.description)")
                    self.logger.log(error: apiError)
                    completion([], apiError)
                } catch {
                    let apiError: APIError = .internalError(message: "API: Couldn't map JSON to an object")
                    self.logger.log(error: apiError)
                    completion([], apiError)
                }
            }
        }
    }
    
    // MARK: Private
    
    private func error(from result: HTTPService.HTTPResult) -> APIError? {
        
        switch result {
            
        case .failure(let error):
            return .httpError(error: error)
            
        case .success(let json, let code):
            if 200...304 ~= code {
                return nil
            }
            
            let (dicJson, formatError) = checkThatItsDictionary(json: json)
            
            guard let json = dicJson else {
                return formatError
            }
            
            let errorText = Mapper<ResponseErrorSchema>().map(JSON: json)?.error
            let httpError = HTTPError.serverError(message: errorText ?? "Unknown error", code: code)
            
            return .httpError(error: httpError)
        }
    }
    
    private func checkThatItsDictionary(json: HTTPJSON) -> ([String: Any]?, APIError) {
        
        let error: APIError = .internalError(message: "API: Expected dictionary, but got an array")
        
        switch json {
            
        case .dictionary(let json):
            return (json, error)
            
        default:
            return(nil, error)
        }
    }
    
    private func checkThatItsArray(json: HTTPJSON) -> ([Any]?, APIError) {
        
        let error: APIError = .internalError(message: "API: Expected array, but got a dictionary")
        
        switch json {
            
        case .array(let json):
            return (json, error)
            
        default:
            return(nil, error)
        }
    }
}
