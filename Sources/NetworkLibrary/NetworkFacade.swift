import Foundation

public class NetworkFacade {

    private var validation = ValidationManager()
    private var networkHelper = NetworkHelper()
    private var resourseParser = ResourceParser()
    var httpHeaderManager: HTTPHeaderManager

    public init(httpHeaderManager: HTTPHeaderManager) {
        self.httpHeaderManager = httpHeaderManager
    }

    public func execute<T: Decodable>(resource: Resource<T>,
                                      complition: @escaping ((Result<T, NetworkError>) -> Void)) {

        let resultOfParsing = resourseParser.parse(from: resource.requestMetaData, using: httpHeaderManager)

        switch resultOfParsing {
        case .success(let requst):
            networkHelper.perfomRequest(request: requst, validation: self.validation) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):

                    complition(self.networkHelper.decode(from: data, to: resource.decodingType))

                case .failure(let error):
                    complition(.failure(error))
                }
            }
        case .failure(let error):
            complition(.failure(error))
        }
    }

    public func execute(requestData: RequestMetaData, complition: @escaping ((Result<Data, NetworkError>) -> Void)) {

        let resultOfParsing = resourseParser.parse(from: requestData, using: httpHeaderManager)

        switch resultOfParsing {
        case .success(let requst):
            networkHelper.perfomRequest(request: requst, validation: self.validation) { result in
                complition(result)
            }
        case .failure(let error):
            complition(.failure(error))
        }
    }

    public func setNewValidationRange(successRange: Range<Int>, failureRange: Range<Int>) throws {
        try self.validation.setRanges(successRange: successRange, failureRange: failureRange)
    }
}
