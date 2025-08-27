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
            NavigationView {
                SignInForm(viewModel: viewModel.makeSignInViewModel()) {
                    NavigationLink("Create Account", destination: CreateAccountForm(viewModel: viewModel.makeCreateAccountViewModel()))
                }
            }
        }
    }
}

struct CreateAccountForm: View {
    @StateObject var viewModel: AuthViewModel.CreateAccountViewModel
    
    var body: some View {
        Form {
            TextField("Name", text: $viewModel.name)
                .textContentType(.name)
                .textInputAutocapitalization(.words)
            TextField("Email", text: $viewModel.email)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $viewModel.password)
                .textContentType(.newPassword)
            Button("Create Account", action: viewModel.submit)
                .onSubmit(viewModel.submit)
        }
        .navigationTitle("Create Account")
    }
}

struct SignInForm<Footer: View>: View {
    @StateObject var viewModel: AuthViewModel.SignInViewModel
    @ViewBuilder let footer: () -> Footer
    
    var body: some View {
        Form {
            TextField("Email", text: $viewModel.email)
                .textContentType(.name)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $viewModel.password)
                .textContentType(.password)
            Button("Sign In", action: viewModel.submit)
                .onSubmit(viewModel.submit)
            footer()
        }
        .navigationTitle("Sign In")
    }
}

#Preview {
    AuthView()
}
