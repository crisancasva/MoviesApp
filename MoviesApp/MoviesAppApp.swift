//
//  MoviesAppApp.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 14/07/25.
//

import SwiftUI

@main
struct MoviesAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
