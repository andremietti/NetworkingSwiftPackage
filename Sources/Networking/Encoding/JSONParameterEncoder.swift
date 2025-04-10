//
//  JSONParameterEncoder.swift
//  NetworkingSwiftPackage
//
//  Created by andre mietti on 08/04/25.
//

import Foundation

public struct JSONParameterEncoder: ParameterURLEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkEncodeError.encodingFailed
        }
    }
}
