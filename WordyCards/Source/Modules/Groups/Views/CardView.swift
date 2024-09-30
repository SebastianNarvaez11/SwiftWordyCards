//
//  CardView.swift
//  WordyCards
//
//  Created by Sebastian on 25/09/24.
//

import SwiftUI

struct CardView: View {
    
    var card: ExerciseModel
    var isTopCard: Bool
    var displacement: CGFloat
    let limitDrag: CGFloat
    
    @State var rotationState: Bool = false
    
    var body: some View {
        VStack{
            switch rotationState {
            case false:
                Text(card.englishWord).typography(.bold, 30, .white).transition(.blurReplace)
            case true:
                Text(card.spanishTranslation)
                    .typography(.bold, 30, .white)
                    .rotation3DEffect(
                        Angle(degrees: Double(180)),
                        axis: (x:0, y:1, z:0),
                        perspective: 0.5
                    ).transition(.blurReplace)
            }
        }
        .frame(maxWidth: UIScreen.main.bounds.width - 150, maxHeight: 400)
        .background(card.color)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .overlay(){
            if(isTopCard){
                VStack{
                    HStack{
                        
                        Image(systemName: "heart.circle")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(Color.white)
                            .opacity(displacement > limitDrag ? 1 : 0)
                            .animation(.easeIn, value: displacement)
                        
                        Spacer()
                        
                        Image(systemName: "x.circle")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(Color.white)
                            .opacity(displacement < -limitDrag ? 1 : 0)
                        
                        
                    }.padding(20)
                    
                    Spacer()
                }
            }
        }
        .rotation3DEffect(Angle(degrees: isTopCard ? Double(rotationState ? 180 : 0) : 0), axis: (x:0, y:1, z:0), perspective: 0.5)
        .animation(.bouncy(duration: 1), value: rotationState)
        .onTapGesture {
            if isTopCard {rotationState.toggle()}
        }
    }
}

#Preview {
    CardView(
        card: ExerciseModel(
            id: "123",
            englishWord: "attach",
            spanishTranslation: "unir",
            image: nil,
            rating: 1,
            color: .accentColor,
            isDeleted: false),
        isTopCard: true,
        displacement:0,
        limitDrag: 120
    )
}
