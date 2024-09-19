//
//  ApplicationSwitcher.swift
//  WordyCards
//
//  Created by Sebastian on 10/08/24.
//

import SwiftUI

struct ApplicationSwitcher: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            switch authViewModel.status {
            case .authenticated:
                MainRouterView{
                    HomeScreen()
                }
                
            case .unauthenticated:
                AuthRouterView{
                    LoginScreen()
                }
                
            case .checking:
                SplashScreen()
            }
        }
    }
}

#Preview {
    ApplicationSwitcher().environmentObject(AuthViewModel())}
