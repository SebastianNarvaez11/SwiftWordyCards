//
//  ApiRequest.swift
//  WordyCards
//
//  Created by Sebastian on 29/08/24.
//

import Foundation

class APIRequest<Resource: ApiResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    typealias ModelType = Resource.ModelType
    
    func decode(_ data: Data) throws -> ModelType {
        return try JSONDecoder().decode(ModelType.self, from: data)
    }
    
    func execute(method: String, body: Encodable? = nil, hasToken: Bool = false) async throws -> ModelType {
        return try await load(url: resource.url, method: method, body: body, hasToken: hasToken)
    }
}
