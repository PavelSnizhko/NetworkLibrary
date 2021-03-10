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
    var headers: [String : String]?
    
    public init(endpoint: String, method: HTTPMethods, body: Data?, headers: [String : String]?) {
        self.endpoint = endpoint
        self.method = method
        self.body = body
        self.headers = headers
    }
}
