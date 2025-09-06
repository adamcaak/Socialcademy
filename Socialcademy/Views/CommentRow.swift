//
//  CommentRow.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 06/09/2025.
//

import SwiftUI

struct CommentRow: View {
    let comment: Comment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Text(comment.author.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                Text(comment.timestamp.formatted())
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            Text(comment.content)
                .font(.headline)
                .fontWeight(.regular)
        }
        .padding(5)
    }
}

struct CommentRow_Previews: PreviewProvider {
    static var previews: some View {
        CommentRow(comment: Comment.testComment)
            .previewLayout(.sizeThatFits)
    }
}
