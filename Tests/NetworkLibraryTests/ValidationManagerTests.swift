//
//  File.swift
//  
//
//  Created by Павел Снижко on 10.03.2021.
//

import XCTest
@testable import NetworkLibrary

final class ValidationManagerTests: XCTest {
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
    }
    
}

