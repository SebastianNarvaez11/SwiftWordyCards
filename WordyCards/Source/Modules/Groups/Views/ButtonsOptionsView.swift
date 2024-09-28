//
//  ButtonsOptionsView.swift
//  WordyCards
//
//  Created by Sebastian on 28/09/24.
//

import SwiftUI

struct ButtonsOptionsView: View {
    
    var onLike: (() -> Void)
    var onDislike: (() -> Void)
    
    var body: some View {
        HStack(spacing: 100){
            
            Button(action: {
                onDislike()
            }) {
                Image(systemName: "x.circle.fill")
                    .resizable()
                    .foregroundStyle(Color.danger)
                    .frame(width: 50, height: 50)
            }
            
            Button(action: {
                onLike()
            }) {
                Image(systemName: "heart.circle.fill")
                    .resizable()
                    .foregroundStyle(Color.success)
                    .frame(width: 50, height: 50)
            }
        }.padding(.top, 40)
    }
}

#Preview {
    ButtonsOptionsView(onLike: {}, onDislike: {})
}
