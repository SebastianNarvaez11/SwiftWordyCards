//
//  SearchBarView.swift
//  WordyCards
//
//  Created by Sebastian on 11/08/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var isShowBanner:Bool
    @State var searchText:String = ""

    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundStyle(.defaultText)
            
            
            if !isShowBanner {
                TextField("Buscar", text: $searchText).frame( height: 40).typography(.medium)
            }
        }
        .padding(.horizontal)
        .frame(width: nil, height: 70)
        .background(Capsule().fill(.backgroundPrimary))
        .onTapGesture {
            withAnimation(.bouncy){
                isShowBanner = false
            }
            
        }
    }
}

#Preview {
    SearchBarView(isShowBanner: .constant(true))
}
