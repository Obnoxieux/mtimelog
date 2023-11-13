//
//  TextSuggestionsTab.swift
//  mtimelog
//
//  Created by David Battefeld on 13.11.23.
//

import SwiftUI
import SwiftData

struct TextSuggestionsTab: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \TextSuggestion.suggestionText) var suggestions: [TextSuggestion] // needs Predicate if filtering by type
    @State private var newSuggestion = ""
    
    let columns = [
        GridItem(.adaptive(minimum: 60)),
    ]
    
    var body: some View {
        Form {
            Section(header: Text("Custom Text Suggestions for Project IDs")) {
                if suggestions.isEmpty {
                    Text("You haven't added any custom text suggestions yet.")
                } else {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(suggestions, id: \.id) { suggestion in
                            Text(suggestion.suggestionText)
                                .textSelection(.disabled)
                                .foregroundStyle(.white)
                                .padding(5)
                                .background(.indigo, in: RoundedRectangle(cornerRadius: 8))
                                .contextMenu {
                                    Button("Delete Suggestion") {
                                        modelContext.delete(suggestion)
                                        do {
                                            try modelContext.save()
                                        } catch {
                                            print("couldn't immediately save due to: \(error.localizedDescription)")
                                        }
                                    }
                                }
                        }
                    }
                }
                LabeledContent("New Suggestion") {
                    HStack {
                        TextField("New Suggestion", text: $newSuggestion)
                            .textFieldStyle(.roundedBorder)
                            .labelsHidden()
                        Button("Add") {
                            if !newSuggestion.isEmpty {
                                modelContext.insert(TextSuggestion(suggestionFields: SuggestionFields.id, suggestionText: newSuggestion))
                                newSuggestion = ""
                                do {
                                    try modelContext.save()
                                } catch {
                                    print("couldn't immediately save due to: \(error.localizedDescription)")
                                }
                            }
                        }
                        .keyboardShortcut(.defaultAction)
                    }
                }
                Text("Suggestions entered here will be used to provide options when creating new tasks.")
                    .foregroundStyle(.secondary)
                    .font(.callout)
            }
        }
        .textSelection(.enabled)
        .formStyle(.grouped)
        .animation(.default, value: suggestions)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: TextSuggestion.self, configurations: config)
    
    for suggestion in TextSuggestion.sampleData {
        container.mainContext.insert(suggestion)
    }
    return TextSuggestionsTab()
        .frame(width: 500, height: 500)
        .modelContainer(container)
}
