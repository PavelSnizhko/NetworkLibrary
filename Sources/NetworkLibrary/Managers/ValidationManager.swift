//
//  ValidationManager.swift
//  
//
//  Created by Павел Снижко on 06.03.2021.
//

import Foundation

public enum StatusCode {
    case success
    case failure(Int)
    case undefinedStatus(Int)
    
}

struct ValidationManager {
    let validIntervalValues = 100..<600
    var successRange = 200..<300
    var failureRange = 300..<600
    
    func validate(using response: HTTPURLResponse) -> StatusCode {
        
        let statusCode = response.statusCode
        
        switch response.statusCode {
        case self.successRange:
            return .success
        case self.failureRange:
            return .failure(statusCode)
        default:
            return .undefinedStatus(statusCode)
        }
    }
    
    mutating func setRanges(successRange: Range<Int>, failureRange: Range<Int>) {
        self.successRange = successRange
        self.failureRange = failureRange
    }
    
}
