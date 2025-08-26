//
//  AuthViewModel.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 26/08/2025.
//

import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    
    private let authService = AuthService()
    
    init() {
        authService.$isAuthenticated.assign(to: &$isAuthenticated)
    }
    
    func signIn() {
        Task {
            do {
                try await authService.signIn(email: email, password: password)
            } catch {
                print("[AuthViewModel] Cannot sign in: \(error)")
            }
        }
    }
    
    func makeSignInViewModel() -> SignInViewModel {
        return SignInViewModel(action: authService.signIn(email:password:))
    }

    func makeCreateAccountViewModel() -> CreateAccountViewModel {
        return CreateAccountViewModel(action: authService.createAccount(name:email:password:))
    }

}

extension AuthViewModel {
    class SignInViewModel: FormViewModel<(email: String, password: String)> {
        convenience init(action: @escaping Action) {
            self.init(initialValue: (email: "", password: ""), action: action)
        }
    }
    
    class CreateAccountViewModel: FormViewModel<(name: String, email: String, password: String)> {
        convenience init(action: @escaping Action) {
            self.init(initialValue: (name: "", email: "", password: ""), action: action)
        }
    }
}
