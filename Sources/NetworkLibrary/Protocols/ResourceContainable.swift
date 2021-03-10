//
//  ResourceContainable.swift
//  
//
//  Created by Павел Снижко on 09.03.2021.
//

import Foundation

public protocol ResourceContainable {
    associatedtype T

    var requestMetaData: RequestMetaData { get }
    var decodingType: T.Type { get }
}
