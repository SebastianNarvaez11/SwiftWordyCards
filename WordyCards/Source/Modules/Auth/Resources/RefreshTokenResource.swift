//
//  RefreshTokenResource.swift
//  WordyCards
//
//  Created by Sebastian on 14/09/24.
//

import Foundation

struct RefreshTokenResource: ApiResource {
    typealias ModelType = RefreshTokenResponse
    var path: String = "/api/v1/auth/refresh-token"
    var queryItems: [URLQueryItem]? = nil
}
