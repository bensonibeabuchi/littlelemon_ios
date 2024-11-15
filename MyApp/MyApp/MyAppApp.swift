//
//  MyAppApp.swift
//  MyApp
//
//  Created by Benson on 15/11/2024.
//

import SwiftUI

@main
struct MyAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
