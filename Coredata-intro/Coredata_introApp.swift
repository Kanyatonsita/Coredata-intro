//
//  Coredata_introApp.swift
//  Coredata-intro
//
//  Created by Kanyaton Somjit on 2023-04-26.
//

import SwiftUI

@main
struct Coredata_introApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
