//
//  File.swift
//  
//
//  Created by Павел Снижко on 10.03.2021.
//

import XCTest
@testable import NetworkLibrary

final class ValidationManagerTests: XCTestCase {
    var validationManager = ValidationManager()
    
    func testSettingNewRanges() {
        
        let successRange = validationManager.successRange
        let failureRange = validationManager.failureRange
        
        do {
            try validationManager.setRanges(successRange: 100..<300, failureRange: 300..<400)
        } catch _ {
            XCTFail("it mustn't be")
        }
        
        XCTAssertNotEqual(successRange, validationManager.successRange)
        XCTAssertNotEqual(failureRange, validationManager.failureRange)
        
        
        do {
            try validationManager.setRanges(successRange: 0..<300, failureRange: 300..<600)
        } catch let error {
            
            guard let error = error as? NetworkError else {
                XCTFail("it mustn't be")
                return
            }
            
            XCTAssertEqual(error, NetworkError.impossibleRange)
        }
    }
    
}


