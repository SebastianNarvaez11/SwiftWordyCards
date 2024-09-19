//
//  GetGroupsResponse.swift
//  WordyCards
//
//  Created by Sebastian on 12/09/24.
//

import Foundation

struct GetGroupsResponse {
    let groups: [GroupModel]
    let totalGroups: Int
    let currentPage: Int
    let totalPages: Int
}

extension GetGroupsResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case groups, totalGroups, currentPage, totalPages
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.groups = try container.decode([GroupModel].self, forKey: .groups)
        self.currentPage = try container.decode(Int.self, forKey: .currentPage)
        self.totalGroups = try container.decode(Int.self, forKey: .totalGroups)
        self.totalPages = try container.decode(Int.self, forKey: .totalPages)
    }
}
