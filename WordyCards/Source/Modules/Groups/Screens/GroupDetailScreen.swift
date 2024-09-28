//
//  GroupDetailScreen.swift
//  WordyCards
//
//  Created by Sebastian on 23/09/24.
//

import SwiftUI

struct GroupDetailScreen: View {
    
    @EnvironmentObject var groupViewModel: GroupViewModel
    @EnvironmentObject var router: MainRouter
    @State var isAppearing: Bool = false
    
    var id: String
    @State var group: GroupDetailModel? = nil
    
    
    var body: some View {
        VStack{
            if groupViewModel.isLoadingGroup {
                VStack{
                    SpinnerView()
                }
            }else if let group {
                VStack{
                    Text(group.name)
                    Text(group.iconName)
                    
                    Button(action: {
                        router.navigateTo(route: .groupSwipeCards(id: id))
                    }) {
                        Image(systemName: "greetingcard.fill")
                            .resizable()
                            .foregroundStyle(Color.primary)
                            .frame(width: 50, height: 50)
                    }
                    
                    ScrollView(){
                        ForEach(Array(group.exercises.enumerated()), id: \.element.id){ index, exercise in
                            ExerciseItemView(exercise: exercise)
                                .offset(x: 0, y: isAppearing ? 0 : 200)
                                .scaleEffect(isAppearing ? 1 : 0)
                                .animation(.bouncy(duration: 0.9).delay(TimeInterval(index) * 0.1), value: isAppearing)
                        }
                    }
                    
                    Spacer()
                }.onAppear(){
                    isAppearing = true
                }
            }else {
                Text("No group found")
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(10)
        .onAppear(){
            Task {
                group = await groupViewModel.getGroupDetailById(id: id)
            }
        }
        //        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GroupDetailScreen(id: "d6d2e78c-0592-4246-93de-837f1bbcc11c")
        .environmentObject(GroupViewModel())
}
