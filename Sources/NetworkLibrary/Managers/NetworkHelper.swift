//
//  NetworkHelper.swift
//  
//
//  Created by Павел Снижко on 06.03.2021.
//

import Foundation

struct NetworkHelper: Networkable {
    
    let urlSession = URLSession.shared
    let jsonDecoder = JSONDecoder()
    
    func perfomRequest(request: URLRequest, validation: ValidationManager, complition: @escaping (Result<Data, NetworkError>) -> Void) {
        urlSession.dataTask(with: request) { data, urlResponse, error in
            
            guard let response = urlResponse as? HTTPURLResponse else {
                complition(.failure(.unknown))
                return
            }
            
            switch validation.validate(using: response) {
            case .success:
            
                guard let data = data else {
                    complition(.failure(.badData))
                    return
                }
                
                complition(.success(data))
                
            case .failure(code: let statusCode):
                
                complition(.failure(.invalidStatusCode(statusCode)))
                
            case .undefinedStatus(code: let statusCode):
                
                complition(.failure(.invalidStatusCode(statusCode)))
                
            }
        }.resume()
    }
    
    func decode<T: Decodable>(from data: Data, to type: T.Type) -> Result<T, NetworkError> {
        do {
            print(data)
            let result = try jsonDecoder.decode(type.self, from: data)
            return .success(result)
        } catch {
            return .failure(.decoding(error.localizedDescription))
        }
    }
    
}
