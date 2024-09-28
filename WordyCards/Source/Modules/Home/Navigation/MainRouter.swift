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
    case groupDetail(id: String)
    case groupSwipeCards(id: String)
}


class MainRouter: BaseRouter<MainPaths> {
    
    @ViewBuilder func view(for route: MainPaths) -> some View {
        switch route {
        case .home:
            HomeScreen()
        case .profile:
            ProfileScreen()
        case .groupDetail(let id):
            GroupDetailScreen(id: id)
        case .groupSwipeCards(let id):
            SwipeCardsScreen(id: id)
        }
    
    }
}
