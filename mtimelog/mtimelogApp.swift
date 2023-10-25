//
//  mtimelogApp.swift
//  mtimelog
//
//  Created by David Battefeld on 25.06.23.
//

import SwiftUI

@main
struct mtimelogApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Workday.self)
    }
}
