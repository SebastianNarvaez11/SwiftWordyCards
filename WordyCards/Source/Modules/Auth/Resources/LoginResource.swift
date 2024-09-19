//
//  LoginResource.swift
//  WordyCards
//
//  Created by Sebastian on 29/08/24.
//

import Foundation


struct LoginResource: ApiResource {
    typealias ModelType = LoginResponse
    var path: String = "/api/v1/auth/login"
    var queryItems: [URLQueryItem]? = nil
}
