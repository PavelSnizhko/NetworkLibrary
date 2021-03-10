//
//  NetworkError.swift
//  
//
//  Created by Павел Снижко on 09.03.2021.
//

import Foundation

public enum NetworkError: Error, Equatable {

    case badURL
    case inappropriateRequestData
    case invalidStatusCode(Int)
    case unknown
    case badData
    case decoding(String)
    case impossibleRange
}
