//
//  BaseRouter.swift
//  WordyCards
//
//  Created by Sebastian on 5/09/24.
//

import Foundation
import SwiftUI

class BaseRouter<RouteType: Hashable>: RouterProtocol {
    @Published var path: NavigationPath = NavigationPath()
    
    @ViewBuilder func view(for route: RouteType) -> some View {
        fatalError("Implement `view(for:)` in subclass")
    }
    
    func navigateTo(route: RouteType) {
        path.append(route)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
