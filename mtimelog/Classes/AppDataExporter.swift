//
//  AppDataExporter.swift
//  mtimelog
//
//  Created by David Battefeld on 08.11.23.
//

import Foundation

class AppDataExporter {
    enum Format {
        case json, text
    }
    
    func exportJSON(workdays: [Workday]) -> String {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        if let data = try? encoder.encode(workdays) {
            return String(decoding: data, as: UTF8.self)
        } else {
            return "Encoding failed"
        }
    }
}
