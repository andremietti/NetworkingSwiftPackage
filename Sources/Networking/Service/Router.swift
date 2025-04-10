//
//  Router.swift
//  NetworkingSwiftPackage
//
//  Created by andre mietti on 09/04/25.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {
    
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { ( data, response, error) in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    func buildRequest(from route: Endpoint) throws -> URLRequest {
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
