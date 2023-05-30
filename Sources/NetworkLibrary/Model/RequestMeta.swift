//
//  File.swift
//  
//
//  Created by Павел Снижко on 09.03.2021.
//

import Foundation

public struct RequestMetaData {
    let endpoint: String
    let method: HTTPMethods
    let body: Data?
    var headers: [String: String]?
    let queryItems: [URLQueryItem]?

    public init(endpoint: String, method: HTTPMethods, body: Data? = nil, headers: [String: String]? = nil, queryItems: [URLQueryItem]? = nil) {
        self.endpoint = endpoint
        self.method = method
        self.body = body
        self.headers = headers
        self.queryItems = queryItems
    }
}
