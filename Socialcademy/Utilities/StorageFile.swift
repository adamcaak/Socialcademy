//
//  StorageFile.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 08/09/2025.
//

import Foundation
import FirebaseStorage

struct StorageFile {
    private let storageReference: StorageReference
    
    func putFile(from fileURL: URL) async throws -> Self {
        _ = try await storageReference.putFile(from: fileURL)
        return self
    }
    
    func getDownloadURL() async throws -> URL {
        return try await storageReference.downloadURL()
    }
    
    func delete() async throws {
        try await storageReference.delete()
    }
}

extension StorageFile {
    private static let storage = Storage.storage()
    
    static func with(namespace: String, identifier: String) -> StorageFile {
        let path = "\(namespace)/\(identifier)"
        let storageReference = storage.reference().child(path)
        return StorageFile(storageReference: storageReference)
    }
}
