//
//  JSONFile.swift
//  mtimelog
//
//  Created by David Battefeld on 08.11.23.
//

import Foundation
import UniformTypeIdentifiers
import SwiftUI

struct JSONFile: FileDocument {
    static var readableContentTypes = [UTType.json]

    var text = ""

    init(initialText: String = "") {
        text = initialText
    }

    // this initializer loads data that has been saved previously
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        }
    }

    // this will be called when the system wants to write our data to disk
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}
