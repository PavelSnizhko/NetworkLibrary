import Foundation
import RxSwift

public struct NetworkFacade {
    private var validation = ValidationManager()
    private var networkHelper = NetworkHelper()
    private var resourseParser = ResourceParser()
    
    var httpHeaderManager: HTTPHeaderManager
    
    public init(httpHeaderManager: HTTPHeaderManager = .init(headers: [:])) {
        self.httpHeaderManager = httpHeaderManager
    }
    
    /// To execute network reqeust where shuld be decoding
    public func execute<T: Decodable>(resource: Resource<T>,
                                      completion: @escaping ((Result<T, NetworkError>) -> Void)) {
        
        let resultOfParsing = resourseParser.parse(from: resource.requestMetaData, using: httpHeaderManager)
        
        switch resultOfParsing {
        case .success(let requst):
            networkHelper.perfomRequest(request: requst, validation: self.validation) { result in
                switch result {
                case .success(let data):
                    completion(self.networkHelper.decode(from: data, to: resource.decodingType))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    /// To execute network reqeust withoud decoding
    public func execute(requestData: RequestMetaData, completion: @escaping ((Result<Data, NetworkError>) -> Void)) {
        
        let resultOfParsing = resourseParser.parse(from: requestData, using: httpHeaderManager)
        
        switch resultOfParsing {
        case .success(let requst):
            networkHelper.perfomRequest(request: requst, validation: self.validation) { result in
                completion(result)
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    public mutating func setNewValidationRange(successRange: Range<Int>, failureRange: Range<Int>) throws {
        try self.validation.setRanges(successRange: successRange, failureRange: failureRange)
    }
}
