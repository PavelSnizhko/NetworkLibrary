//
//  NetworkFacadeTests.swift
//  
//
//  Created by Павел Снижко on 10.03.2021.
//

import XCTest
import NetworkFacade


struct Post: Decodable {
   var id: Int
   var title: String
   var userId: Int
   var body: String
}



final class NetworkFacadeTests: XCTestCase {
    func testExecute() {
        
    }
}
