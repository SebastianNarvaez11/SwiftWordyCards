//
//  LoginResponse.swift
//  WordyCards
//
//  Created by Sebastian on 27/08/24.
//

import Foundation

struct LoginResponse {
    let user: User
    let accessToken: String
    let refreshToken: String
}


extension LoginResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case user, accessToken, refreshToken
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accessToken = try container.decode(String.self, forKey: .accessToken)
        self.refreshToken = try container.decode(String.self, forKey: .refreshToken)
        self.user = try container.decode(User.self, forKey: .user)
    }
} 
