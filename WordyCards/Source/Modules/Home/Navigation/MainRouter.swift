//
//  MainRouter.swift
//  WordyCards
//
//  Created by Sebastian on 5/09/24.
//

import Foundation
import SwiftUI

enum MainPaths: Hashable {
    case home
    case profile
}


class MainRouter: BaseRouter<MainPaths> {
    
    @ViewBuilder func view(for route: MainPaths) -> some View {
        switch route {
        case .home:
            HomeScreen()
        case .profile:
            ProfileScreen()
        }
    }
}
