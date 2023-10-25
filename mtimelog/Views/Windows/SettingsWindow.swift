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
        }
        .frame(width: 450, height: 250)
    }
}

#Preview {
    SettingsWindow()
}