//
//  APIEndPoints.swift
//  NetworkingSwiftPackage
//
//  Created by andre mietti on 08/04/25.
//

import Foundation

enum APIEndPoints {
    case character(id: Int)
    case charactersAlive(page: Int)
    case charactersDead(page: Int)
    case charactersAlien(page: Int)
    case characterImage(id: Int)
    case charactersFavorites(ids: [Int])
}
