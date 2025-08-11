//
//  Posts.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 11/08/2025.
//

import Foundation

struct Posts: Identifiable {
    var title: String
    var content: String
    var authorName: String
    var timeStamp = Date()
    var id = UUID()
}
