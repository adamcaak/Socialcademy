//
//  NewPostForm.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 12/08/2025.
//

import SwiftUI

struct NewPostForm: View {
    @State private var post = Post(title: "", content: "", authorName: "")
    @State private var state = FormState.idle
    @Environment(\.dismiss) private var dismiss
    
    typealias CreateAction = (Post) async throws -> Void
    let createAction: CreateAction
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $post.title)
                    TextField("Author Name", text: $post.authorName)
                }
                Section("Content") {
                    TextEditor(text: $post.content)
                        .multilineTextAlignment(.leading)
                }
                Button(action: createPost) {
                    if state == .working {
                        ProgressView()
                    } else {
                        Text("Create Post")
                    }
                }
                .font(.headline)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .listRowBackground(Color.accentColor)
            }
            .onSubmit(createPost)
            .navigationTitle(Text("New Post"))
        }
        .disabled(state == .working)
        .alert("Cannot create Post", isPresented: $state.isError, actions: {}) {
            Text("Sorry, Something went wrong. Try again later.")
        }
    }
    
    private func createPost() {
        Task {
            state = .working
            do {
                try await createAction(post)
                dismiss()
            } catch {
                print("[New Post] Cannot create post: \(error)")
                state = .error
            }
        }
    }
    
    enum FormState {
        case idle, working, error
        
        var isError: Bool {
            get {
                self == .error
            }
            set {
                guard !newValue else { return }
                self = .idle
            }
        }
    }
}

struct NewPostForm_Previews: PreviewProvider {
    static var previews: some View {
        NewPostForm(createAction: { _ in })
    }
}
