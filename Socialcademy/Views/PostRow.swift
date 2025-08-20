//
//  PostRow.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 11/08/2025.
//

import SwiftUI

struct PostRow: View {
    @ObservedObject var viewModel: PostRowViewModel
    @State private var showConfirmationDialog = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(viewModel.post.authorName)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Spacer()
                Text(viewModel.post.timeStamp.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
            }
            .foregroundColor(.gray)
                Text(viewModel.title)
                .font(.title3)
                .fontWeight(.semibold)
            Text(viewModel.post.content)
            HStack {
                FavoriteButton(isFavorite: viewModel.isFavorite, action: viewModel.favoritePost)
                Spacer()
                Button(role: .destructive, action: {
                    showConfirmationDialog = true
                }) {
                    Label("Delete", systemImage: "trash")
                }
                
                .confirmationDialog("Are you sure you want to delete this post?", isPresented: $showConfirmationDialog, titleVisibility: .visible) {
                    Button("Delete", role: .destructive, action: viewModel.deletePost)
                }
                .alert("Cannot Delete Post", error: $viewModel.error)
            }
            .labelStyle(.iconOnly)
            .buttonStyle(.borderless)
        }
        .padding(.vertical)
    }
}

private extension PostRow {
    struct FavoriteButton: View {
        let isFavorite: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                if isFavorite {
                    Label("Remove from Favorites", systemImage: "heart.fill")
                } else {
                    Label("Add to Favorites", systemImage: "heart")
                }
            }
            .foregroundColor(isFavorite ? .red : .gray)
            .animation(.default, value: isFavorite)
        }
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            PostRow(viewModel: PostRowViewModel(post: Post.testPost, deleteAction: {}, favoriteAction: {}))
        }
    }
}
