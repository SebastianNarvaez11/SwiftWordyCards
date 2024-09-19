//
//  StatusBanner.swift
//  WordyCards
//
//  Created by Sebastian on 10/08/24.
//

import SwiftUI

struct StatusBannerView: View {
    
    @Binding var isShowBanner:Bool
    
    var body: some View {
        HStack(spacing:15){
            Image(systemName: "trophy.circle.fill")
                .resizable()
                .foregroundStyle(.white)
                .scaledToFit()
                .frame(width: 40, height: 40)
                .onTapGesture {
                    withAnimation(.bouncy){
                        isShowBanner = true
                    }
                    
                }
            
            if isShowBanner {
                VStack(alignment: .leading){
                    HStack{
                        Text("Palabras aprendidas")
                            .typography(.semiBold, 15, .white)
                        
                        Spacer()
                        
                        Text("4/20")
                            .typography(.bold, 15, .white)
                    }
                    
                    ZStack(alignment:.leading){
                        
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(height: 12)
                            .foregroundStyle(Color(.systemGray5))
                        
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: 50, height: 12)
                            .foregroundStyle(.green)
                        
                    }
                }.transition(.offset(x: 300, y:0))
            }
        }
        .padding()
        .frame(width: isShowBanner ? nil : 70, height: 70)
        .background(BannerShape().fill(.accent))
        .animation(.bouncy(duration: 0.9), value: isShowBanner)
        .onAppear(){
            isShowBanner = true
        }
    }
}



#Preview {
    StatusBannerView(isShowBanner: .constant(true))
}
