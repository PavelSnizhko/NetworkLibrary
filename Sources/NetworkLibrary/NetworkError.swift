//
//  NetworkError.swift
//  
//
//  Created by Павел Снижко on 09.03.2021.
//

import Foundation

public enum NetworkError: Error {
    case badURL
    case badRequestData
    case invalidStatusCode(Int)
    case unknown
    case badData
    case decoding(Error)
}
