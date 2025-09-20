//
//  fetchrequest_bugApp.swift
//  fetchrequest-bug
//
//  Created by Benjamin Kindle on 9/20/25.
//

import SwiftUI
import CoreData

@main
struct fetchrequest_bugApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
