//
//  NetworkRouter.swift
//  NetworkingSwiftPackage
//
//  Created by andre mietti on 08/04/25.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

protocol NetworkRouter {
    associatedtype Endpoint: EndPointType
    func request(_ route: Endpoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
