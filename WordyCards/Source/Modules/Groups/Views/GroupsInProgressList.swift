//
//  GroupsInProgressList.swift
//  WordyCards
//
//  Created by Sebastian on 14/08/24.
//

import SwiftUI

struct GroupsInProgressList: View {
    
    @EnvironmentObject var groupViewModel: GroupViewModel
    @EnvironmentObject var router: MainRouter
    @State var isAppearing:Bool = false
    
    let columns = [
           GridItem(.flexible()),
           GridItem(.flexible()),
       ]
    
    var body: some View {
        
        switch groupViewModel.status {
        case .initialLoading:
            SpinnerView()
                .onAppear(){
                    Task{
                        await groupViewModel.getGroups()
                    }
                }
            
        default:
            ScrollView(showsIndicators: false){
                LazyVGrid(columns: columns, spacing: 30){
                    
                    if(groupViewModel.status == .success || groupViewModel.status == .loadingNextPage){
                        ForEach(Array(groupViewModel.groups.enumerated()), id: \.element.id){ index, group in
                            GroupInProgressCardView(group: group)
                                .offset(x: isAppearing ? 0 : 200, y:0)
                                .animation(.bouncy.delay(TimeInterval(index) * 0.1), value: isAppearing)
                                .onTapGesture {
                                    router.navigateTo(route: .groupDetail(id: group.id))
                                }
                        }
                    }
                    
                    if(groupViewModel.status == .loadingNextPage){
                        SpinnerView()
                    }
                    
                    if(groupViewModel.status == .success && groupViewModel.hasNextPage){
                        SpinnerView()
                            .onAppear(){
                                groupViewModel.status = .loadingNextPage
                                Task{
                                    await groupViewModel.getGroups()
                                }
                            }
                    }
                    
                }.padding(.horizontal)
            }
//            .frame(height: 190)
            .onAppear(){
                isAppearing = true
            }
        }
    }
}

#Preview {
    GroupsInProgressList().environmentObject(GroupViewModel())
}
