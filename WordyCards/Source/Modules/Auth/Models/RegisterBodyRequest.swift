//
//  RegisterBodyRequest.swift
//  WordyCards
//
//  Created by Sebastian on 3/09/24.
//

import Foundation

struct RegisterBodyRequest : Encodable {
    let name: String
    let email: String
    let password: String
    let confirmPassword: String
}
