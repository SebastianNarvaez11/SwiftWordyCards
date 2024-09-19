//
//  ApiResource.swift
//  WordyCards
//
//  Created by Sebastian on 28/08/24.
//

import Foundation

protocol ApiResource {
    associatedtype ModelType: Decodable
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}


extension ApiResource {
    var url: URL {
        var components = URLComponents(string: "https://wordy-cards-backend.vercel.app")!
        components.path = path
        
        // Si hay queryItems, los añadimos
        if let queryItems = queryItems {
            components.queryItems = queryItems
        }
        
        return components.url!
    }
}
