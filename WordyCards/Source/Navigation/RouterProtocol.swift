//
//  RouterProtocol.swift
//  WordyCards
//
//  Created by Sebastian on 5/09/24.
//

import Foundation
import SwiftUI

protocol RouterProtocol: ObservableObject {
    var path: NavigationPath { get set }
    
    associatedtype Route: Hashable
    associatedtype ViewType: View

    @ViewBuilder func view(for route: Route) -> ViewType

    func navigateTo(route: Route)
    func navigateBack()
    func popToRoot()
}
