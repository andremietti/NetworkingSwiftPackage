//
//  Router.swift
//  NetworkingSwiftPackage
//
//  Created by andre mietti on 09/04/25.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {
    
    private var task: URLSessionTask?
    
    public func request(_ route: EndPoint) async throws -> (data: Data, response: URLResponse) {
        let session = URLSession.shared
        
        do {
            let request = try self.buildRequest(from: route)
            return try await withCheckedThrowingContinuation { continuation in
                task = session.dataTask(with: request, completionHandler: { ( data, response, error) in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else {
                        guard let data = data else {
                            fatalError("Expected non-nil result 'data' in the non-error case")
                        }
                        guard let response = response else {
                            fatalError("Expected non-nil result 'response' in the non-error case")
                        }
                        continuation.resume(returning: (data, response))
                    }
                })
                
                self.task?.resume()
            }
        } catch {
            throw error
        }

    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let urlParameters):
                try self.configureURLParameters(urlParameters: urlParameters ?? .defaultValue, request: &request)
            case .requestParametersAndHeaders(let urlParameters, let additionHeaders):
                self.additionalHeaders(additionHeaders, request: &request)
                try self.configureURLParameters(urlParameters: urlParameters ?? .defaultValue, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    func configureURLParameters(urlParameters: Parameters, request: inout URLRequest) throws {
        do {
            try URLParamaterEncoder.encode(urlRequest: &request, with: urlParameters)
        } catch {
            throw error
        }
    }
    
    func additionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for(key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
