//
//  HTTPTask.swift
//  NetworkingSwiftPackage
//
//  Created by andre mietti on 08/04/25.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask<T: Codable> {
    case request
    case requestParameters(urlParameters: Parameters?)
    case requestParametersAndHeaders(urlParameters: Parameters?, additionHeaders: HTTPHeaders?)

    // if we need body parameters:
    //case requestParameters(bodyParameters: T?, urlParameters: Parameters?)

}
