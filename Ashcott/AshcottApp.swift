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
    @State private var imageCache = ImageCache()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(imageCache)
        }
        .modelContainer(for: RatedDrink.self)
    }

    init() {
//        try? Tips.resetDatastore()
        try? Tips.configure()
    }
}
