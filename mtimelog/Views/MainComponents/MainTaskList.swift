//
//  MainTaskList.swift
//  mtimelog
//
//  Created by David Battefeld on 25.06.23.
//

import SwiftUI

struct MainTaskList: View {
    var body: some View {
        List {
            Text("Stuff")
            Text("Stuff")
            Text("Stuff")
            Text("Stuff")
        }
        .listStyle(.inset(alternatesRowBackgrounds: true))
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Button("Button here") {
                        
                    }
                }
            }
    }
}

struct MainTaskList_Previews: PreviewProvider {
    static var previews: some View {
        MainTaskList()
    }
}
