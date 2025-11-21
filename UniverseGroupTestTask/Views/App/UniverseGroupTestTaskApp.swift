//
//  UniverseGroupTestTaskApp.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 19.11.2025.
//

import SwiftUI
import CoreData

@main
struct UniverseGroupTestTaskApp: App {
    @StateObject private var viewModel = PhotoInfoViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
