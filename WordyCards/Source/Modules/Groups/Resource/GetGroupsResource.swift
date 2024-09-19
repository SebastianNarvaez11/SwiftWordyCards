//
//  GetGroupsResource.swift
//  WordyCards
//
//  Created by Sebastian on 12/09/24.
//

import Foundation

struct GetGroupsResource: ApiResource {
    typealias ModelType = GetGroupsResponse
    var path: String = "/api/v1/groups"
    
    var take: Int?
    var page: Int?
    
    var queryItems: [URLQueryItem]? {
        var items = [URLQueryItem]()
        
        if let take = take {
            items.append(URLQueryItem(name: "take", value: "\(take)"))
        }
        
        if let page = page {
            items.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        
        // Si no hay parámetros, devolvemos nil
        return items.isEmpty ? nil : items
    }
}
