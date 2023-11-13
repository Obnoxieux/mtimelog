//
//  TextSuggestion.swift
//  mtimelog
//
//  Created by David Battefeld on 13.11.23.
//

import Foundation
import SwiftData

@Model
final class TextSuggestion: Identifiable {
    @Attribute(.unique) 
    var id = UUID()
    var suggestionFields: SuggestionFields
    var suggestionText: String
    
    init(id: UUID = UUID(), suggestionFields: SuggestionFields, suggestionText: String) {
        self.id = id
        self.suggestionFields = suggestionFields
        self.suggestionText = suggestionText
    }
}

extension TextSuggestion {
    static var sampleData = [
        TextSuggestion(suggestionFields: SuggestionFields.id, suggestionText: "ABC-010")
    ]
}

enum SuggestionFields: Codable {
    case id, desc
}
