//
//  CheckStatusResource.swift
//  WordyCards
//
//  Created by Sebastian on 11/09/24.
//

import Foundation


struct CheckStatusResource : ApiResource {
    typealias ModelType = CheckStatusResponse
    var path: String = "/api/v1/auth/check-status"
    var queryItems: [URLQueryItem]? = nil
}
