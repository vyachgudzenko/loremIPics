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
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
