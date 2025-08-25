//
//  AuthService.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 25/08/2025.
//

import Foundation

@MainActor
class AuthService: ObservableObject {
    @Published var isAuthenticated: Bool = false
    
    private let auth = Auth.auth()
    private var listener = AuthStateDidChangeListenerHandle?
    
    init() {
        listener = auth.addStateDidChangeListener { [weak self] _, user in
            self?.isAuthenticated = user != nil
        }
    }
}

private extension FirebaseAuth.User {
    func updateProfile<T>(_ keyPath: WritableKeyPath<UserProfileChangeRequest, T>, to newValue: T) async throws {
        var profileChangeRequest = createProfileChangeRequest()
        profileChangeRequest[keyPath: keyPath] = newValue
        try await profileChangeRequest.commitChanges()
    }
}
