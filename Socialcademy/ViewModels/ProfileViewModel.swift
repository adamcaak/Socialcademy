//
//  ProfileViewModel.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 09/09/2025.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject, ErrorHandler {
    @Published var name: String
    @Published var imageURL: URL?
    @Published var error: Error?
    
    private let authService: AuthService
    
    init(user: User, authService: AuthService) {
        self.name = user.name
        self.imageURL = user.imageURL
        self.authService = authService
    }
    
    func signOut() {
        withErrorHandlingTask(perform: authService.signOut)
    }
}
