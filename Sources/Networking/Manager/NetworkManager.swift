//
//  NetworkManager.swift
//  NetworkingSwiftPackage
//
//  Created by andre mietti on 10/04/25.
//

import Foundation

class NetworkManager {
    private let router = Router<APIEndPoints>()
    
    enum NetworkResponse: String {
        case success
        case authenticationError = "You need be authenticated first"
        case badRequest = "Bad Request"
        case outdated = "The url requested is outdated"
        case failed = "Network request failed"
        case noData = "Response returned with no data to decode"
        case unableToDecode = "Could not decode the response"
    }
    
    enum Result<String> {
        case success
        case failure(String)
    }
    
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299:
            return .success
        case 401...500:
            return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
}
