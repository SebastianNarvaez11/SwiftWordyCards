//
//  MainRouterView.swift
//  WordyCards
//
//  Created by Sebastian on 5/09/24.
//

import Foundation
import SwiftUI

struct MainRouterView<Content: View>: View {
    
    @StateObject private var router: MainRouter = MainRouter()
    private let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: MainRouter.Route.self) { route in
                    router.view(for: route)
                }
        }
        .environmentObject(router)
    }
}
