//
//  GetGroupDetailResponse.swift
//  WordyCards
//
//  Created by Sebastian on 23/09/24.
//

import Foundation

struct GetGroupDetailResponse {
    let group: GroupDetailModel
    let countEasy, countMedium, countHard: Int
}

extension GetGroupDetailResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case group, countEasy, countMedium, countHard
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.group = try container.decode(GroupDetailModel.self, forKey: .group)
        self.countEasy = try container.decode(Int.self, forKey: .countEasy)
        self.countMedium = try container.decode(Int.self, forKey: .countMedium)
        self.countHard = try container.decode(Int.self, forKey: .countHard)
    }
}

