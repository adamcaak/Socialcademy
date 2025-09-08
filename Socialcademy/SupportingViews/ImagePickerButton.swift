//
//  ImagePickerButton.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 08/09/2025.
//

import SwiftUI

struct ImagePickerButton<Label: View>: View {
    @Binding var imageURL: URL?
    @ViewBuilder var label: () -> Label
    @State private var showImageSourceDialog = false
    @State private var sourceType: UIImagePickerController.SourceType?
    
    var body: some View {
        Button(action: {}) {
            label()
        }
    }
}

#Preview {
    ImagePickerButton()
}
