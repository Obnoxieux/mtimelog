//
//  ExportSettingsTab.swift
//  mtimelog
//
//  Created by David Battefeld on 08.11.23.
//

import SwiftUI
import SwiftData

struct ExportSettingsTab: View {
    @Query var workdays: [Workday]
    @State private var showFileExporter = false
    @State private var exportedJSON: JSONFile? = nil
    @State private var exportedText: JSONFile? = nil
    let appDataExporter = AppDataExporter()
    
    var body: some View {
        Form {
            Section(header: Text("Export app data to")) {
                Button("JSON file") {
                    exportedJSON = JSONFile(initialText: appDataExporter.exportJSON(workdays: workdays))
                    showFileExporter.toggle()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .formStyle(.grouped)
        
        .fileExporter(isPresented: $showFileExporter, document: exportedJSON, contentType: .json, defaultFilename: "mtimelog_data_export", onCompletion: { result in
            switch result {
                case .success(let fileURL):
                    print("Successful export to \(fileURL)")
                case .failure(let error):
                print("Failed export with \(error.localizedDescription)")
            }
            exportedJSON = nil
        })
    }
}

#Preview {
    ExportSettingsTab()
}
