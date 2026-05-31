//
//  AshcottApp.swift
//  Ashcott
//
//  Created by Nigel Gee on 13/05/2026.
//

import SwiftData
import SwiftUI
import TipKit

@main
struct AshcottApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: RatedDrink.self)
    }

    init() {
//        try? Tips.resetDatastore()
        try? Tips.configure()
    }
}
