//
//  ErrorHandler.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 07/09/2025.
//

import Foundation

@MainActor
protocol StateManager: AnyObject {
    var error: Error? { get set }
}

extension StateManager {
    func withErrorHandlingTask(perform action: @escaping () async throws -> Void) {
        Task {
            do {
                try await action()
            } catch {
                print("[\(Self.self)] Error: \(error)")
                self.error = error
            }
        }
    }
}
