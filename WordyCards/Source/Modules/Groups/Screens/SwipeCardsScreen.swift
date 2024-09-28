//
//  SwipeCardsScreen.swift
//  WordyCards
//
//  Created by Sebastian on 25/09/24.
//

import SwiftUI

struct SwipeCardsScreen: View {
    
    @EnvironmentObject var groupViewModel: GroupViewModel
    
    var id: String
    @State var cards: [ExerciseModel] = []
    @GestureState var dragState: AnimationDragState = .inactive
    let limitDrag: CGFloat = 120
    
    var body: some View {
        VStack{
            ZStack{
                ForEach(Array(cards.enumerated().reversed()), id: \.element.id){ index, card in
                    let isTopCard: Bool = index == 0
                    
                    // Simplifica las expresiones en variables intermedias
                    let xOffset = isTopCard ? card.isDeleted ? (card.deletedFrom == .right ? 400 : -400) : dragState.translation.width : dragState.isDragging ? CGFloat(index) * 20 : (CGFloat(index) * 30)
                    let yOffset = isTopCard ? dragState.translation.height : 0
                    let scale = isTopCard ? (dragState.isPressing ? 1.1 : 1) : dragState.isDragging ? 1 - ((CGFloat(index) / 100) * 2 ) : 1 - ((CGFloat(index) / 100) * 4)
                    let rotation = isTopCard ? Angle(degrees: Double(dragState.translation.width / 15)) : .zero
                    
                    CardView(card: card, isTopCard: isTopCard)
                        .shadow(radius: 5, x: 5, y: 5)
                        .offset(x: xOffset, y: yOffset)
                        .scaleEffect(scale)
                        .rotationEffect(rotation)
                        .animation(.interpolatingSpring(stiffness: 200, damping: 100), value: dragState.translation)
                        .animation(.bouncy, value: dragState.isPressing)
                        .animation(.easeIn, value: card.isDeleted)
                        .animation(.bouncy(duration: 0.7, extraBounce: 0.3).delay(TimeInterval(index)/10), value: index)
                        .gesture(
                            LongPressGesture(minimumDuration: 0.02)
                                .sequenced(before: DragGesture())
                                .updating(self.$dragState, body: { value, state, transaction in
                                    switch value {
                                    case .first(false):
                                        state = .pressing
                                    case .second(true, let drag):
                                        state = .dragging(translation: drag?.translation ?? .zero)
                                    default:
                                        break
                                    }})
                                .onEnded({ value in
                                    guard case .second(true, let drag?) = value else { return }
                                    if drag.translation.width < -limitDrag || drag.translation.width > limitDrag {
                                        if let deletedCard = cards.firstIndex(where: { $0.id == card.id}){
                                            cards[deletedCard].isDeleted = true
                                            cards[deletedCard].deletedFrom = drag.translation.width < -limitDrag ? .left : .right
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            cards.removeFirst()
                                        }
                                    }
                                }))
                }
            }
            
            ButtonsOptionsView(onLike: {
                cards[0].isDeleted = true
                cards[0].deletedFrom = .right
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    cards.removeFirst()
                }
            }, onDislike: {
                cards[0].isDeleted = true
                cards[0].deletedFrom = .left
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    cards.removeFirst()
                }
            })
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundSecondary)
        .onAppear(){
            Task {
                if let group = await groupViewModel.getGroupDetailById(id: id) {
                    cards = group.exercises
                } else {
                    print("Failed to load group details")
                }
            }
        }
    }
}

#Preview {
    SwipeCardsScreen(id: "sdsd").environmentObject(GroupViewModel())
}
