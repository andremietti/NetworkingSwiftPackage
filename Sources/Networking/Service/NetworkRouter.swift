//
//  NetworkRouter.swift
//  NetworkingSwiftPackage
//
//  Created by andre mietti on 08/04/25.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

public protocol NetworkRouter {
    associatedtype EndPoint: EndPointType
//    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func request(_ route: EndPoint) async throws -> (data: Data, response: URLResponse)
    func cancel()
}
