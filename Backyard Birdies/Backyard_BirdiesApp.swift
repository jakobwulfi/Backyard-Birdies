//
//  Backyard_BirdiesApp.swift
//  Backyard Birdies
//
//  Created by dmu mac 31 on 09/12/2024.
//

import SwiftUI
import FirebaseCore

@main
struct Backyard_BirdiesApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(StateController())
                .environment(BirdspotController())
                .environment(LocationController())
        }
    }
}
