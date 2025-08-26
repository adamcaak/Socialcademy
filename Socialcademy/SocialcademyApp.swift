//
//  SocialcademyApp.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 10/08/2025.
//

import SwiftUI
import Firebase

@main
struct SocialcademyApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}
