//
//  RegisterResource.swift
//  WordyCards
//
//  Created by Sebastian on 3/09/24.
//

import Foundation

struct RegisterResource: ApiResource {
    typealias ModelType = RegisterResponse
    var path: String = "/api/v1/auth/register"
    var queryItems: [URLQueryItem]? = nil
}
