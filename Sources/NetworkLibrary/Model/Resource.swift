//
//  Resource.swift
//  
//
//  Created by Павел Снижко on 09.03.2021.
//

import Foundation

public struct Resource<SomeType>: ResourceContainable {
    public typealias T = SomeType
    public let requestMetaData: RequestMetaData
    public let decodingType: T.Type

    public init(requestMetaData: RequestMetaData, decodingType: T.Type) {
        self.requestMetaData = requestMetaData
        self.decodingType = decodingType
    }
}
