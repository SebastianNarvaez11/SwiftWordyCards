//
//  AuthViewModel.swift
//  WordyCards
//
//  Created by Sebastian on 24/08/24.
//

import Foundation
import KeychainSwift

class AuthViewModel: ObservableObject {
    @Published var status: AuthStatus = .checking
    @Published var user: User?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showAlert: Bool = false
    
    let keychain = KeychainSwift()
    
    @MainActor func login(credentials : LoginBodyRequest) async  {
        do {
            guard !isLoading else { return }
            defer { isLoading = false }
            isLoading = true
            
            let resource = LoginResource()
            let request = APIRequest(resource: resource)
            let res = try await request.execute(method: "POST", body: credentials)
            
            self.user = res.user
            keychain.set(res.accessToken, forKey: "ACCESS-TOKEN-WC")
            keychain.set(res.refreshToken, forKey: "REFREHS-TOKEN-WC")
            self.status = .authenticated
        } catch {
            print("Ocurrio un error: \(error.localizedDescription)")
            self.errorMessage = error.localizedDescription
            self.showAlert = true
            self.status = .unauthenticated
        }
    }
    
    @MainActor func register(data: RegisterBodyRequest) async -> Bool {
        do{
            guard !isLoading else { return false}
            defer { isLoading = false }
            isLoading = true
            
            let resource = RegisterResource()
            let request = APIRequest(resource: resource)
            let res = try await request.execute(method: "POST", body: data)
            
            self.user = res.user
            return true
        } catch {
            print(error)
            self.errorMessage = error.localizedDescription
            self.showAlert = true
            self.status = .unauthenticated
            return false
        }
    }
    
    @MainActor func checkStatus() async {
        do{
            guard !isLoading else { return }
            
            defer { isLoading = false }
            isLoading = true

            let resource = CheckStatusResource()
            let request = APIRequest(resource: resource)
            let res = try await request.execute(method: "GET", hasToken: true)
            self.user = res.user
            self.status = .authenticated
        } catch {
            print("error al revisar el estado de la autenticacion: ", error.localizedDescription)
            self.logout()
        }
    }
    
    func logout() {
        self.status = .unauthenticated
        self.user = nil
        keychain.delete("ACCESS-TOKEN-WC")
        keychain.delete("REFREHS-TOKEN-WC")
    }
}
