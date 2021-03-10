//
//  ResourceParser.swift
//  
//
//  Created by Павел Снижко on 05.03.2021.
//

import Foundation

struct ResourceParser {
    
    func parse(from requestData: RequestMetaData, using manager: HTTPHeaderManager) -> Result<URLRequest, NetworkError>  {
        
        guard let url =  URL(string: requestData.endpoint) else {
            return .failure(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestData.method.rawValue
        urlRequest.allHTTPHeaderFields = requestData.headers
        
        if let headers = requestData.headers {
            urlRequest.allHTTPHeaderFields = manager.getHeadersForRequest(comparingWith: headers)
        }
        else {
            urlRequest.allHTTPHeaderFields = manager.headers
        }
        
        if let body = requestData.body {
            urlRequest.httpBody = body
            
            guard requestData.method != .get else {
                return .failure(.inappropriateRequestData)
            }
        }
        
        return .success(urlRequest)
    }
}
