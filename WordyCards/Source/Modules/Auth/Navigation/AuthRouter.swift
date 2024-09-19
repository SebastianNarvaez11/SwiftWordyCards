//
//  AuthRouter.swift
//  WordyCards
//
//  Created by Sebastian on 5/09/24.
//

import Foundation
import SwiftUI

enum AuthPath: Hashable {
    case login
    case register
}

class AuthRouter: BaseRouter<AuthPath> {

    @ViewBuilder func view(for route: AuthPath) -> some View {
        switch route {
        case .login:
            LoginScreen()
        case .register:
            RegisterScreen()
        }
    }
}
