//
//  ProfileView.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 26/08/2025.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    var body: some View {
        Button("Sign Out", action: {
            try! Auth.auth().signOut()
        })
    }
}

#Preview {
    ProfileView()
}
