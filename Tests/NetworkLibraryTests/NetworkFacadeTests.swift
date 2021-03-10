//
//  NetworkFacadeTests.swift
//  
//
//  Created by Павел Снижко on 10.03.2021.
//

import XCTest
@testable import NetworkLibrary


struct Post: Codable, Equatable {
   var id: Int
   var title: String
   var userId: Int
   var body: String
}



final class NetworkFacadeTests: XCTestCase {
    let networkFacade = NetworkFacade(httpHeaderManager: HTTPHeaderManager(headers: ["Content-type" : "application/json; charset=UTF-8"]))
    let jsonEncoder = JSONEncoder()
    
    
    func testExecuteWithoutDecoding() {
        
        let post = Post(id: 1001, title: "foo", userId: 1, body: "fsjafj safasd  fadasfa")
        let jsonData = try? jsonEncoder.encode(post)

        let requestData = RequestMetaData(endpoint: "https://jsonplaceholder.typicode.com/posts", method: .post, body: jsonData, headers: nil)
    
        networkFacade.execute(requestData: requestData) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }
    
    
    func testExecuteWithDecoding() {
        let post = Post(id: 1001, title: "foo", userId: 1, body: "fsjafj safasd  fadasfa")
        let jsonData = try? jsonEncoder.encode(post)

        let requestDataWithBody = RequestMetaData(endpoint: "https://jsonplaceholder.typicode.com/post/1", method: .get, body: jsonData, headers: nil)

        let resourceWithBody = Resource<Post>(requestMetaData: requestDataWithBody, decodingType: Post.self)

        networkFacade.execute(resource: resourceWithBody) { result in
            switch result {
            case .success:
                XCTFail("it mustn't be")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.inappropriateRequestData)
            }
        }

        let requestDataWithoutBody = RequestMetaData(endpoint: "https://jsonplaceholder.typicode.com/post/1", method: .get, body: nil, headers: nil)
        let resourceWithoutBody = Resource<Post>(requestMetaData: requestDataWithoutBody, decodingType: Post.self)
        
        let respondedPost = Post(id: 1,
                                 title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                                 userId: 1,
                                 body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
        
        networkFacade.execute(resource: resourceWithoutBody) { result in
            switch result {
            case .success(let post):
                XCTAssertEqual(post, respondedPost)
            case .failure:
                XCTFail("it mustn't be")
            }
        }
        
        
    }
}
