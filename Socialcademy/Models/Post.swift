//
//  Posts.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 11/08/2025.
//

import Foundation

struct Post: Identifiable {
    var title: String
    var content: String
    var authorName: String
    var timeStamp = Date()
    var id = UUID()
}

extension Post {
    static var testPost = Post(
        title: "Lorem ipsum",
        content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor quam id massa faucibus dignissim. Nullam eget metus id nisl malesuada condimentum. Nam viverra fringilla erat, ut fermentum nunc feugiat eu.",
        authorName: "Jamie Harris")
}
