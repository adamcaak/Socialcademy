//
//  NewCommentForm.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 06/09/2025.
//

import SwiftUI

struct NewCommentForm: View {
    @StateObject private var viewModel: FormViewModel<Comment>
    
    var body: some View {
        HStack {
            TextField("Comment", text: $viewModel.content)
            Button(action: viewModel.submit) {
                if viewModel.isWorking {
                    ProgressView()
                } else {
                    Label("Post", systemImage: "paperplane")
                }
            }
        }
        .alert("Cannot Post Comment", error: $viewModel.error)
        .animation(.default, value: viewModel.isWorking)
        .disabled(viewModel.isWorking)
        .onSubmit(viewModel.submit)
    }
}

#Preview {
    NewCommentForm()
}
