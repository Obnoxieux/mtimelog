//
//  NavigationBar.swift
//  mtimelog
//
//  Created by David Battefeld on 25.06.23.
//

import SwiftUI
import SwiftData

struct NavigationBar: View {
    @Environment(\.modelContext) private var modelContext
    @Query var workdays: [Workday]
    @State private var workdayToDelete: Workday? = nil
    @State var showingDeleteConfirmationDialog = false
    @State var showPopover = false
    
    var body: some View {
        List {
            Section(
                header: Text("STATIC: Calendar Week 4")
            ) {
                ForEach(workdays, id: \.self) { workday in
                    NavigationLink(destination: MainTaskList(workday: workday), label: {
                        Text(workday.date, format: .dateTime.day().month().year())
                    })
                    .contextMenu {
                        Button("Delete Working Day") {
                            workdayToDelete = workday
                            showingDeleteConfirmationDialog = true
                        }
                    }
                }
            }
            Section {
                Button(action: {
                    showPopover = true
                }, label: {
                    Label("New working day", systemImage: "plus")
                })
                .buttonStyle(.plain)
                .popover(isPresented: $showPopover) {
                    AddNewWorkdaySheet()
                }
            }
        }
        .listStyle(.sidebar)
        .navigationTitle("Workdays")
        .focusedSceneValue(\.addWorkday, $showPopover)
        
        .confirmationDialog("Confirm Deletion", isPresented: $showingDeleteConfirmationDialog) {
            Button("Delete Working Day", role: .destructive) {
                if let workday = workdayToDelete {
                    modelContext.delete(workday)
                    do {
                        try modelContext.save()
                    } catch {
                        print("couldn't immediately save deletion")
                    }
                    workdayToDelete = nil
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("The working day and all tasks associated with it will irrevocably deleted!")
        }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}
