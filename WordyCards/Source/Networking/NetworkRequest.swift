//
//  NetworkRequest.swift
//  WordyCards
//
//  Created by Sebastian on 29/08/24.
//

import Foundation
import KeychainSwift


protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) throws -> ModelType
    func execute(method:String, body: Encodable?, hasToken: Bool) async throws -> ModelType
}

extension NetworkRequest {
    func load(url: URL, method: String, body: Encodable? = nil, hasToken: Bool = false) async throws -> ModelType {
        let keychain = KeychainSwift()
        
        var request = URLRequest(url:url)
        request.httpMethod = method
        
        if let body = body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                throw APIError.encodingError
            }
        }
        
        if hasToken {
            let token = keychain.get("ACCESS-TOKEN-WC") ?? ""
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknownError
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return try self.decode(data)
        case 401:
            let refreshToken = keychain.get("REFREHS-TOKEN-WC") ?? ""
            
            var requestToken = URLRequest(url: RefreshTokenResource().url)
            requestToken.httpMethod = "GET"
            requestToken.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
            
            let (dataToken, responseToken) = try await URLSession.shared.data(for: requestToken)
            
            guard let httpResponseToken = responseToken as? HTTPURLResponse else {
                throw APIError.unknownError
            }
            
            switch httpResponseToken.statusCode {
            case 200...299:
                let dataContainer = try JSONDecoder().decode(RefreshTokenResponse.self, from: dataToken)
                keychain.set(dataContainer.newAccessToken, forKey: "ACCESS-TOKEN-WC")
                return try await load(url: url, method: method, body: body, hasToken: hasToken)
                
            default:
                throw APIError.unauthorized
            }
        default:
            if let error = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                print(error)
                throw APIError.serverError(message: error.message)
            } else {
                throw APIError.decodingError
            }
        }
    }
}
