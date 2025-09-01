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
        if viewModel.user != nil {
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
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            TextField("Name", text: $viewModel.name)
                .textContentType(.name)
            TextField("Email", text: $viewModel.email)
                .textContentType(.emailAddress)
            SecureField("Password", text: $viewModel.password)
                .textContentType(.newPassword)
        } footer: {
            Button("Create Account", action: viewModel.submit)
                .buttonStyle(.primary)
            Button("Sign In", action: dismiss.callAsFunction)
        }
        .onSubmit(viewModel.submit)
        .alert("Cannot Create Account", error: $viewModel.error)
        .disabled(viewModel.isWorking)
    }
}

struct SignInForm<Footer: View>: View {
    @StateObject var viewModel: AuthViewModel.SignInViewModel
    @ViewBuilder let footer: () -> Footer
    
    var body: some View {
        Form {
                TextField("Email", text: $viewModel.email)
                    .textContentType(.emailAddress)
                SecureField("Password", text: $viewModel.password)
                    .textContentType(.password)
            } footer: {
                Button("Sign In", action: viewModel.submit)
                    .buttonStyle(.primary)
                footer()
                    .padding()
            }
            .onSubmit(viewModel.submit)
            .alert("Cannot Sign In", error: $viewModel.error)
            .disabled(viewModel.isWorking)
    }
}

struct Form<Content: View, Footer: View>: View {
    @ViewBuilder let content: () -> Content
    @ViewBuilder let footer: () -> Footer
    
    var body: some View {
        VStack {
            Text("Socialcademy")
                .font(.title.bold())
            content()
                .padding()
                .background(Color.secondary.opacity(0.15))
                .cornerRadius(10)
            footer()
        }
        .navigationBarHidden(true)
        .padding()
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(10)
            .animation(.default, value: isEnabled)
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle {
        PrimaryButtonStyle()
    }
}


#Preview {
    AuthView()
}
