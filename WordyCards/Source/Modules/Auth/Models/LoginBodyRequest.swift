//
//  LoginRequest.swift
//  WordyCards
//
//  Created by Sebastian on 27/08/24.
//

import Foundation

struct LoginBodyRequest: Encodable {
    let email: String
    let password: String
}
