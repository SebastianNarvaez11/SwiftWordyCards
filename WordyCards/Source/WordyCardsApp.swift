//
//  WordyCardsApp.swift
//  WordyCards
//
//  Created by Sebastian on 10/08/24.
//

import SwiftUI

@main
struct WordyCardsApp: App {
    
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var groupViewModel = GroupViewModel()
    
    var body: some Scene {
        WindowGroup {
            ApplicationSwitcher()
                .environmentObject(authViewModel)
                .environmentObject(groupViewModel)
        }
    }
}
