//
//  HTTPHeaderManager.swift
//  
//
//  Created by Павел Снижко on 09.03.2021.
//
import Foundation

public struct HTTPHeaderManager {
    
    var headers: [String : String]
    
    public init(headers: [String : String]) {
        self.headers = headers
    }
    
    func getHeadersForRequest(comparingWith headers: [String : String]) -> [String : String] {
        var actualHeaders = self.headers
        
        headers.forEach {
            actualHeaders[$0.0] = $0.1
        }
        
        return actualHeaders
    }

}
