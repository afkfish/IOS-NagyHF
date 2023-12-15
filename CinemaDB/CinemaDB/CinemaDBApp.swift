//
//  CinemaDBApp.swift
//  CinemaDB
//
//  Created by Beni Kis on 29/11/2023.
//

import SwiftUI

@main
struct CinemaDBApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
