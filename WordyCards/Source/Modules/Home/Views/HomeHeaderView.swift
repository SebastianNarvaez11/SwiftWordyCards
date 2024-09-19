//
//  HomeHeaderView.swift
//  WordyCards
//
//  Created by Sebastian on 11/08/24.
//

import SwiftUI

struct HomeHeaderView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack(spacing:30){
            HStack{
                Image("Icon").resizable().frame(width: 40, height: 40)
                Spacer()
                Image(systemName: "gearshape.fill").font(.system(size: 25))
            }
            
            HStack{
                VStack(alignment:.leading){
                    Text("Hello,").typography(.medium, 25)
                    Text("\(authViewModel.user?.name ?? "")!").typography(.bold, 35)
                }
                Spacer()
            }
        }.padding(.horizontal, 20)
    }
}

#Preview {
    HomeHeaderView()
}
