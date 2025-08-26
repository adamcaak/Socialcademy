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
}
