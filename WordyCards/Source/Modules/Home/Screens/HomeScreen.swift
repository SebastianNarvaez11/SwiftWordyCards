//
//  HomeScreenView.swift
//  WordyCards
//
//  Created by Sebastian on 10/08/24.
//

import SwiftUI
import KeychainSwift

struct HomeScreen: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var router: MainRouter
    @EnvironmentObject var groupViewModel: GroupViewModel

    @State var isShowBanner:Bool = false
    let keychain = KeychainSwift()
    
    
    var body: some View {
        VStack{
            
            HomeHeaderView()
            
            HStack(spacing:20){
                SearchBarView(isShowBanner: $isShowBanner)
                
                StatusBannerView(isShowBanner: $isShowBanner)
            }.padding(.leading, 20)
            
            HStack{
                Text("En progreso:").typography(.semiBold)
                Spacer()
            }
            .padding(20)
            
            
            GroupsInProgressList()
            
            Button(action:{authViewModel.logout()}){
                Text("Salir")
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundSecondary)
    }
    
    
}

#Preview {
    HomeScreen()
        .environmentObject(AuthViewModel())
        .environmentObject(MainRouter())
}
