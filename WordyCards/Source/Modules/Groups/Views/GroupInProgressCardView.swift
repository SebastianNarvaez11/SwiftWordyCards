//
//  GroupInProgressCardView.swift
//  WordyCards
//
//  Created by Sebastian on 13/08/24.
//

import SwiftUI

struct GroupInProgressCardView: View {
    
    let group:GroupModel
    
    var body: some View {
        
        let colorStatus:Color = getColorStatus(countEasy: group.countEasy, total: group.countExercises)
        let percentage: Double = (Double(group.countEasy) * 100.0) / Double(group.countExercises)
        
        VStack(alignment: .leading){
            HStack(){
                ZStack{
                    Circle()
                        .stroke(colorStatus .opacity(0.1), lineWidth:6)
                        .frame(width: 50, height: 50)
                    
                    Circle()
                        .trim(from: 0, to:  Double(percentage / 100))
                        .stroke(colorStatus, lineWidth:6)
                        .rotationEffect(Angle(degrees: -90))
                        .frame(width: 50, height: 50)
                    
                }
                
                Spacer()
                
                Text("\(group.iconName)")
                    .font(.custom("Ionicons", size: 50))
                    .foregroundStyle(colorStatus .opacity(0.4))
            }
            .padding(.horizontal)
            .padding(.top)
            
            Spacer()
            
            VStack(alignment:.leading){
                Text(group.name)
                    .typography(.bold, 16, colorStatus)
                    .lineLimit(2)
                    .padding(.trailing)
                    .frame(height: 50)
                
                HStack{
                    VStack(){
                        
                        Text("\(group.countExercises) Palabras")
                            .typography(.semiBold, 12, colorStatus)
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    VStack{
                        Image(systemName: "arrow.forward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .bold()
                            .foregroundStyle(.white)
                    }
                    .frame(width: 60, height: 40)
                    .background(UnevenRoundedRectangle(
                        cornerRadii: .init(
                            topLeading: 25,
                            bottomLeading: 0,
                            bottomTrailing: 25,
                            topTrailing: 0),
                        style: .continuous)
                        .foregroundStyle(colorStatus))
                }
                .frame(height: 40)
            }
            .padding(.leading)
        }
        .frame(width: 160, height: 180)
        .background(RoundedRectangle(cornerRadius: 25.0)
            .foregroundStyle(colorStatus .opacity(0.2)))
    }
}

#Preview {
    GroupInProgressCardView(group: GroupModel(id: "asdasd", name: "Numeros", iconName: "home", countEasy: 5, countExercises: 200))
}
