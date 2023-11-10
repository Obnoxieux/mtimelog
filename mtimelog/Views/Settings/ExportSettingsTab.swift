//
//  ExportSettingsTab.swift
//  mtimelog
//
//  Created by David Battefeld on 08.11.23.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

struct ExportSettingsTab: View {
    @Query var workdays: [Workday]
    @State private var showFileExporter = false
    @State private var exportedFile: ExportFile? = nil
    @State private var fileType = UTType.plainText
    let appDataExporter = AppDataExporter()
    
    var body: some View {
        Form {
            Section(header: Text("Export app data to")) {
                HStack {
                    Button("JSON File") {
                        fileType = UTType.json
                        exportedFile = ExportFile(initialText: appDataExporter.exportJSON(workdays: workdays))
                        showFileExporter.toggle()
                    }
                    Button("Plain Text File") {
                        fileType = UTType.plainText
                        exportedFile = ExportFile(initialText: appDataExporter.exportPlainText(workdays: workdays))
                        showFileExporter.toggle()
                    }
                }
            }
        }
        .textSelection(.enabled)
        .formStyle(.grouped)
        
        .fileExporter(isPresented: $showFileExporter, document: exportedFile, contentType: fileType, defaultFilename: "mtimelog_data_export", onCompletion: { result in
            switch result {
                case .success(let fileURL):
                    print("Successful export to \(fileURL)")
                case .failure(let error):
                print("Failed export with \(error.localizedDescription)")
            }
            exportedFile = nil
        })
    }
}

#Preview {
    ExportSettingsTab()
}
