//
//  SplashScreen.swift
//  WordyCards
//
//  Created by Sebastian on 24/08/24.
//

import SwiftUI

struct SplashScreen: View {
    
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        VStack(spacing: 20){
            Image("IconSecondary")
            
            if (authViewModel.isLoading){
                SpinnerView(color: .white)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.accent)
        .onAppear(){
            Task{
                await authViewModel.checkStatus()
            }
        }
    }
}

#Preview {
    SplashScreen().environmentObject(AuthViewModel())
}
