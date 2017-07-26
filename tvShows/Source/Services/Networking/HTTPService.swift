//
//  HTTPService.swift
//  Services
//
//  Created by Andrey Sevrikov on 10/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation

class HTTPService {

    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
    }
    
    enum HTTPResult {
        case success(json: HTTPJSON, code: Int)
        case failure(error: HTTPError)
    }
    
    static let shared: HTTPService = HTTPService()
    
    let session: URLSession = {
        
        let conf = URLSessionConfiguration.default
        conf.timeoutIntervalForRequest = 10
        
        return URLSession(configuration: conf)
    }()
    
    var headers: [String: String] = [:]
    
    init() {

        headers = ["Content-Type": "application/json"]
    }
    
    @discardableResult
    func request(url: String, method: HTTPMethod, parameters: [String: Any] = [:], configuration: URLSessionConfiguration? = nil, completion: @escaping (HTTPResult) -> Void) -> URLSessionDataTask? {
        
        let (createdRequest, error) = self.createRequest(url: url, method: method, parameters: parameters)
        
        guard var request = createdRequest else {
            completion(.failure(error: error ?? .internalError(message: "Couldn't create a request")))
            return nil
        }
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        let requestSession: URLSession
        
        if let configuration = configuration {
            requestSession = URLSession(configuration: configuration)
        } else {
            requestSession = self.session
        }
        
        let task = requestSession.dataTask(with: request) { data, response, error in
            self.handleResponse(data: data, response: response, error: error, completion: completion)
        }
        task.resume()
        
        return task
    }
    
    // MARK: - Private
    
    private func createRequest(url: String, method: HTTPMethod, parameters: [String: Any]) -> (URLRequest?, HTTPError?) {
        
        guard var requestUrl = URL(string: url) else {
            return (nil, .internalError(message: "Request URL is incorrect"))
        }
        
        var httpBody: Data?
        
        switch method {
            
        case .get:
            guard let urlComponents = NSURLComponents(string: url) else {
                return (nil, .internalError(message: "Request URL is incorrect"))
            }
            
            urlComponents.queryItems = []
            
            for (key, value) in parameters {
                urlComponents.queryItems?.append(URLQueryItem(name: key, value: String(describing: value)))
            }

            guard let urlComponentsUrl = urlComponents.url else {
                return (nil, .internalError(message: "Request parameters are in incorrect format"))
            }
            requestUrl = urlComponentsUrl
            print(requestUrl)
            
        default:
            guard let payload = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else {
                return (nil, .internalError(message: "Request parameters are in incorrect format"))
            }
            httpBody = payload
            
            print(requestUrl)
            print(parameters)
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = method.rawValue
        request.httpBody = httpBody
        
        return(request, nil)
    }
    
    private func handleResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (HTTPResult) -> Void) {
        
        guard let response = response as? HTTPURLResponse else {
            completion(.failure(error: .internalError(message: "Couldn't get HTTP info from server response")))
            return
        }
        
        if let error = error {
            completion(.failure(error: .serverError(message: error.localizedDescription, code: response.statusCode)))
            return
        }
        
        guard let data = data else {
            completion(.success(json: .dictionary(json: [:]), code: response.statusCode))
            return
        }
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
            completion(.failure(error: .parserError(message: "Couldn't serialize")))
            return
        }
        
        let httpJson: HTTPJSON?
        
        switch json {
            
        case let json as [String: Any]:
            httpJson = .dictionary(json: json)
            
        case let json as [Any]:
            httpJson = .array(json: json)
            
        default:
            httpJson = nil
        }
        
        guard let serializedJson = httpJson else {
            completion(.failure(error: .parserError(message: "Couldn't serialize")))
            return
        }
        
        print("Got response:\n \(serializedJson)")
        
        completion(.success(json: serializedJson, code: response.statusCode))
    }
}
