//
//  EndPointProtocol.swift
//  NetworkingSwiftPackage
//
//  Created by andre mietti on 08/04/25.
//

import Foundation

public protocol EndPointType {
    associatedtype T: Codable
    var baseURL: URL {get}
    var path: String {get}
    var httpMethod: HTTPMethod {get}
    var task: HTTPTask<T> {get}
    var headers: HTTPHeaders? {get}
}
