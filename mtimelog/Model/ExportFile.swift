//
//  ExportFile.swift
//  mtimelog
//
//  Created by David Battefeld on 08.11.23.
//

import Foundation
import UniformTypeIdentifiers
import SwiftUI

struct ExportFile: FileDocument {
    static var readableContentTypes = [UTType.json, UTType.plainText]

    var text = ""

    init(initialText: String = "") {
        text = initialText
    }

    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        }
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}
