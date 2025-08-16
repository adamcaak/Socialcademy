//
//  EmptyListView.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 16/08/2025.
//

import SwiftUI

struct EmptyListView: View {
    let title: String
    let message: String
    let retryAction: (() -> Void)?
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            Text(message)
            if let retryAction = retryAction {
                Button(action: retryAction) {
                    Text("Try Again")
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 5).stroke(Color.secondary))
                }
                .padding(.top)
            }
        }
        .font(.subheadline)
        .multilineTextAlignment(.center)
        .foregroundColor(.secondary)
        .padding()
    }
}

#Preview {
    EmptyListView()
}
