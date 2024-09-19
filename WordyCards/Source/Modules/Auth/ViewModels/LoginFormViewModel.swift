//
//  LoginFormViewModel.swift
//  WordyCards
//
//  Created by Sebastian on 25/08/24.
//

import Foundation
import Combine

class LoginFormViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isEmailValid: Bool = false
    @Published var isPasswordValid: Bool = false
    @Published var isPressedSubmit: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        $email
            .receive(on: RunLoop.main)
            .map { email in
                return self.isValidEmail(email: email)
            }
            .assign(to: \.isEmailValid, on: self)
            .store(in: &cancellableSet)
        
        $password
            .receive(on: RunLoop.main)
            .map { password in
                return !password.isEmpty
            }
            .assign(to: \.isPasswordValid, on: self)
            .store(in: &cancellableSet)
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
}
