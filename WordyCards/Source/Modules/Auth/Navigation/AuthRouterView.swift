//
//  AuthRouterView.swift
//  WordyCards
//
//  Created by Sebastian on 5/09/24.
//

import SwiftUI

struct AuthRouterView<Content: View>: View {
    
    @StateObject private var router: AuthRouter = AuthRouter()
    private let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: AuthRouter.Route.self) { route in
                    router.view(for: route)
                }
        }
        .environmentObject(router)
    }
}
