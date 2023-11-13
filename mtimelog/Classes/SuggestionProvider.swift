//
//  SuggestionProvider.swift
//  mtimelog
//
//  Created by David Battefeld on 09.11.23.
//

import Foundation
import SwiftData

class SuggestionProvider {
    static let MAX_SUGGESTIONS = 45
    
    static var taskDescriptor: FetchDescriptor<Task> {
        var descriptor = FetchDescriptor<Task>(sortBy: [SortDescriptor(\.startTime, order: .reverse)])
        descriptor.fetchLimit = MAX_SUGGESTIONS
        descriptor.propertiesToFetch = [\.projectID, \.taskDescription]
        return descriptor
    }
    
    static var suggestionDescriptor: FetchDescriptor<TextSuggestion> {
        let descriptor = FetchDescriptor<TextSuggestion>(sortBy: [SortDescriptor(\.suggestionText)])
        return descriptor
    }
    
    // I would very much prefer to pass the whole modelContext here but it may introduce data races
    func loadSuggestions(fields: SuggestionFields, tasks: [Task], suggestions: [TextSuggestion]) async -> [String] {
        var suggestionSet = Set<String>()
        
        for suggestion in suggestions where suggestion.suggestionFields == fields {
            suggestionSet.insert(suggestion.suggestionText)
        }
        
        for task in tasks {
            if fields == .id {
                suggestionSet.insert(task.projectID)
            } else if let desc = task.taskDescription {
                suggestionSet.insert(desc)
            }
        }
        suggestionSet.remove("")
        return Array(suggestionSet)
    }
}
