//
//  NewPostForm.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 12/08/2025.
//

import SwiftUI

struct NewPostForm: View {
    @State private var post = Post(title: "", content: "", authorName: "")
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Author Name", text: $authorName)
                }
                Section("Content") {
                    TextEditor(text: $content)
                        .multilineTextAlignment(.leading)
                }
                Button(action: createPost) {
                    Text("Create Post")
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
    }
    
    private func createPost() {
        print("Create new post!")
    }
}

#Preview {
    NewPostForm()
}
