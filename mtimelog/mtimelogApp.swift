//
//  mtimelogApp.swift
//  mtimelog
//
//  Created by David Battefeld on 25.06.23.
//

import SwiftUI
import SwiftData

@main
struct mtimelogApp: App {
    var container: ModelContainer
    
    let fullSchema = Schema([
        Workday.self,
        Task.self,
        TextSuggestion.self
    ])
    
    init() {
        do {
            container = try ModelContainer(for: fullSchema)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
        .commands {
            CommandGroup(after: CommandGroupPlacement.newItem) {
                AddWorkdayMenuBarButton()
                    .keyboardShortcut("n", modifiers: [.command, .shift])
                AddTaskMenuBarButton()
                    .keyboardShortcut("t")
            }
        }
        
        Settings {
            SettingsWindow()
        }
        .modelContainer(container)
    }
}
