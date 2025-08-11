//
//  PostRow.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 11/08/2025.
//

import SwiftUI

struct PostRow: View {
    let post: Post
    
    var body: some View {
        VStack {
            Text(post.authorName)
            Text(post.timeStamp.formatted())
            Text(post.title)
            Text(post.content)
        }
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            PostRow(post: Post.testPost)
        }
    }
}
