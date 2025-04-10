//
//  URLParamaterEncoder.swift
//  NetworkingSwiftPackage
//
//  Created by andre mietti on 08/04/25.
//

import Foundation

public struct URLParamaterEncoder: ParameterURLEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkEncodeError.missingURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
           !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}
