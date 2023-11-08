//
//  ContentView.swift
//  mtimelog
//
//  Created by David Battefeld on 25.06.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            NavigationBar()
                .navigationSplitViewColumnWidth(min: 120, ideal: 200, max: 200)
        } content: {
            ContentUnavailableView("No Working Day selected", systemImage: "calendar")
                .navigationSplitViewColumnWidth(min: 210, ideal: 500, max: 600)
        } detail: {
            ContentUnavailableView("No Task selected", systemImage: "tray")
                .navigationSplitViewColumnWidth(min: 200, ideal: 500, max: 600)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
