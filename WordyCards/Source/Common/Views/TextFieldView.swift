//
//  TextFieldView.swift
//  WordyCards
//
//  Created by Sebastian on 25/08/24.
//

import SwiftUI

struct TextFieldView: View {
    
    var label: String
    var placeholder: String
    var isSecure: Bool = false
    var hasError: Bool = false
    var errorMessage: String = ""
    
    @Binding var value:String
    
    var body: some View {
        VStack(alignment: .leading){
            Text(label).typography(.bold, 15)
            
            if (isSecure) {
                SecureField(placeholder, text: $value)
                    .padding(.horizontal)
                    .frame(height: 45)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                TextField(placeholder, text: $value)
                    .padding(.horizontal)
                    .frame(height: 45)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
            
            if(hasError){
                Text(errorMessage).typography(.regular, 12, .danger)
            }
        }.padding(.bottom, 10)
    }
}

#Preview {
    TextFieldView(label: "Tu email", placeholder: "Email", value: .constant(""))
}
