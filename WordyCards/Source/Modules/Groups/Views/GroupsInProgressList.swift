//
//  GroupsInProgressList.swift
//  WordyCards
//
//  Created by Sebastian on 14/08/24.
//

import SwiftUI

struct GroupsInProgressList: View {
    
    @EnvironmentObject var groupViewModel: GroupViewModel
    @State var isAppearing:Bool = false
    
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
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack(spacing: 30){
                    
                    if(groupViewModel.status == .success || groupViewModel.status == .loadingNextPage){
                        ForEach(Array(groupViewModel.groups.enumerated()), id: \.element.id){ index, group in
                            GroupInProgressCardView(group: group)
                                .offset(x: isAppearing ? 0 : 200, y:0)
                                .animation(.bouncy.delay(TimeInterval(index) * 0.1), value: isAppearing)
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
            .frame(height: 190)
            .onAppear(){
                isAppearing = true
            }
        }
    }
}

#Preview {
    GroupsInProgressList().environmentObject(GroupViewModel())
}
