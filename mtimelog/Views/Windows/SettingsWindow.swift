//
//  SettingsWindow.swift
//  mtimelog
//
//  Created by David Battefeld on 25.10.23.
//

import SwiftUI

struct SettingsWindow: View {
    var body: some View {
        TabView {
            GeneralSettingsTab()
                .tabItem {
                    Label("General", systemImage: "gearshape.2")
                }
            ExportSettingsTab()
                .tabItem {
                    Label("Export", systemImage: "arrow.down.square")
                }
            TextSuggestionsTab()
                .tabItem {
                    Label("Suggestions", systemImage: "tray.full")
                }
        }
        .frame(width: 450, height: 250)
    }
}

#Preview {
    SettingsWindow()
}
