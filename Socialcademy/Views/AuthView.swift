//
//  AuthView.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 26/08/2025.
//

import SwiftUI

struct AuthView: View {
    @StateObject var viewModel = AuthViewModel()
    var body: some View {
        if viewModel.isAuthenticated {
            MainTabView()
        } else {
            Form {
                TextField("Email", text: $viewModel.email)
                SecureField("Password", text: $viewModel.password)
                Button("Sign In", action: {
                    viewModel.signIn()
                })
            }
        }
    }
}

#Preview {
    AuthView()
}
