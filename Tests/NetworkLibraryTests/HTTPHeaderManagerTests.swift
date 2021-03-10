//
//  HTTPHeaderManagerTests.swift
//  
//
//  Created by Павел Снижко on 10.03.2021.
//

@testable import NetworkLibrary
import XCTest

final class HTTPHeaderManagerTests: XCTestCase {
    var httpHeaderManager = HTTPHeaderManager(headers: ["Content-Type" : "application/json", "Accept" : "application/json"])
    
    func testHeaderMerging() {
        
        let newHeaders = ["Authorization": "Bearer sdjfalkdjfklsdj23423424",
                          "Content-Type": "application/json; charset=utf-8"]
        
        let expectedHeaders = ["Authorization": "Bearer sdjfalkdjfklsdj23423424",
                               "Content-Type": "application/json; charset=utf-8",
                               "Accept" : "application/json"]
        
        let actualHeaders = httpHeaderManager.getHeadersForRequest(comparingWith: newHeaders)
        
        XCTAssertEqual(actualHeaders, expectedHeaders)
        
    }
}
