//
//  EndPointType.swift
//  NetworkingSwiftPackage
//
//  Created by andre mietti on 09/04/25.
//

import Foundation

extension APIEndPoints: EndPointType {
    
    var baseURL: URL {
        return URL(string: "https://rickandmortyapi.com/api")!
    }
    
    var path: String {
        switch self {
        case .character(let id):
            return "character/\(id)"
        case .characterImage(let id):
            return "character/avatar/\(id).jpeg"
        case .charactersFavorites(let ids):
            var path = "character/"
            for (index, id) in ids.enumerated() {
                path += index == ids.count - 1 ? "\(id)" : "\(id), "
            }
            return path
            
        default:
            return "character/"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask<Int> {
        switch self {
        case .charactersAlive(let page):
            return .requestParameters(urlParameters: ["status": "alive", "page": "\(page)"])
        case .charactersDead(let page):
            return .requestParameters(urlParameters: ["status": "dead", "page": "\(page)"])
        case .charactersAlien(let page):
            return .requestParameters(urlParameters: ["status": "alien", "page": "\(page)"])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

