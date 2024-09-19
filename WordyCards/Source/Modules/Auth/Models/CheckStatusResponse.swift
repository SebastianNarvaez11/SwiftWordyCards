//
//  CheckStatusResponse.swift
//  WordyCards
//
//  Created by Sebastian on 11/09/24.
//

import Foundation

struct CheckStatusResponse {
    let user : User
}

extension CheckStatusResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case user
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.user = try container.decode(User.self, forKey: .user)
    }
}
