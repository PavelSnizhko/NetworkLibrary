//
//  ResourceParserTests.swift
//  
//
//  Created by Павел Снижко on 10.03.2021.
//

import XCTest
@testable import NetworkLibrary

final class ResourceParserTests: XCTestCase {
    let resourceParser = ResourceParser()
    let httpHeaderManager = HTTPHeaderManager(headers: ["default name": "default value"])

    func testParse() {
        let endpoint = "https://jsonplaceholder.typicode.com/posts"

        let requestData = RequestMetaData(endpoint: endpoint, method: .post, body: nil, headers: nil)

        let mockRequest = makeRequest(using: endpoint, headers: httpHeaderManager.headers, httpMethod: "POST")

        switch resourceParser.parse(from: requestData, using: httpHeaderManager) {
        case .success(let request):
            XCTAssertEqual(mockRequest, request)
        case .failure:
            XCTFail("it mustn't be")
        }

    }

    func makeRequest(using endpoint: String, headers: [String: String], httpMethod: String) -> URLRequest? {

        guard let url = URL(string: endpoint) else {
            return nil
        }

        var urlRequest = URLRequest(url: url)

        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = httpMethod

        return urlRequest
    }

}
