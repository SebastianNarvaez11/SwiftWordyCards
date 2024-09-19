//
//  User.swift
//  WordyCards
//
//  Created by Sebastian on 27/08/24.
//

import Foundation

struct User {
    let id: String
    var name: String
    var email: String
    var image: URL?
    var isActive: Bool
}

extension User: Codable {
    enum CodingKeys: String, CodingKey {
        case id, name, email, image, isActive
    }
}
