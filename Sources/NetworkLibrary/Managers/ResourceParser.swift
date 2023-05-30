//
//  ResourceParser.swift
//  
//
//  Created by Павел Снижко on 05.03.2021.
//

import Foundation

struct ResourceParser {

    func parse(from requestData: RequestMetaData,
               using manager: HTTPHeaderManager) -> Result<URLRequest, NetworkError> {

        guard var url =  URL(string: requestData.endpoint) else {
            return .failure(.badURL)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestData.method.rawValue
        urlRequest.allHTTPHeaderFields = requestData.headers

        if let headers = requestData.headers {
            urlRequest.allHTTPHeaderFields = manager.getHeadersForRequest(comparingWith: headers)
        } else {
            urlRequest.allHTTPHeaderFields = manager.headers
        }

        if let body = requestData.body {
            urlRequest.httpBody = body

            guard requestData.method != .get else {
                return .failure(.inappropriateRequestData)
            }
        }
        
        if let queryItems = requestData.queryItems {
            urlRequest.url = urlRequest.url?.appending(queryItems)
        }

        return .success(urlRequest)
    }
}

extension URL {
    
    /// Returns a new URL by adding the query items, or nil if the URL doesn't support it.
    /// URL must conform to RFC 3986.
    func appending(_ queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            // URL is not conforming to RFC 3986 (maybe it is only conforming to RFC 1808, RFC 1738, and RFC 2732)
            return nil
        }
        // append the query items to the existing ones
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems

        // return the url from new url components
        return urlComponents.url
    }
    
}
