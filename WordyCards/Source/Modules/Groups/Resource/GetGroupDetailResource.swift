//
//  GetGroupDetailResource.swift
//  WordyCards
//
//  Created by Sebastian on 23/09/24.
//

import Foundation

struct GetGroupDetailResource: ApiResource {
    typealias ModelType = GetGroupDetailResponse
    
    let groupId: String
    var path: String {
        return "/api/v1/groups/\(groupId)"
    }
    
    var queryItems: [URLQueryItem]? = nil
}
