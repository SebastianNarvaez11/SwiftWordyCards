//
//  GroupViewModel.swift
//  WordyCards
//
//  Created by Sebastian on 12/09/24.
//

import Foundation

enum GroupPaginationStatus {
    case initialLoading
    case loadingNextPage
    case success
    
}

class GroupViewModel: ObservableObject {
    @Published var groups: [GroupModel] = []
    @Published var status: GroupPaginationStatus = .initialLoading
    @Published var hasNextPage: Bool = false
    
    var currentPage: Int = 0
    var totalGroups: Int = 0
    var totalPages: Int = 0
    
    @MainActor func getGroups() async {
        do{
            print("cargando la pagina \(currentPage + 1)")
            let resource = GetGroupsResource(take: 8, page: currentPage + 1)
            let request = APIRequest(resource: resource)
            let res = try await request.execute(method: "GET", hasToken: true)
            self.groups.append(contentsOf: res.groups)
            self.currentPage = res.currentPage
            self.totalGroups = res.totalGroups
            self.totalPages = res.totalPages
            self.status = .success
            self.hasNextPage = res.currentPage < res.totalPages
            
        }catch{
            print("Ocurrio un error al obtener los grupos", error.localizedDescription)
        }
    }
}
