//
//  Networkable.swift
//  
//
//  Created by Павел Снижко on 10.03.2021.
//

import Foundation

protocol Networkable {
    func perfomRequest(request: URLRequest, validation: ValidationManager, complition: @escaping (Result<Data, NetworkError>) -> Void)
}
