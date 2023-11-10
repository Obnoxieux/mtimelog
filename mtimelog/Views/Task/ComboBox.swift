//
//  ComboBox.swift
//  mtimelog
//
//  Created by David Battefeld on 09.11.23.
//

import Foundation
import SwiftUI

struct ComboBox: NSViewRepresentable
{
    // The items that will show up in the pop-up menu:
    var items: [String]
    
    // The property on our parent view that gets synced to the current stringValue of the NSComboBox, whether the user typed it in or selected it from the list:
    @Binding var text: String
    

    func makeCoordinator() -> Coordinator {
        return Coordinator(self, textV: $text)
    }
    
    
    func makeNSView(context: Context) -> NSComboBox
    {
        let comboBox = NSComboBox()
        comboBox.usesDataSource = false
        comboBox.completes = true
        comboBox.delegate = context.coordinator
        comboBox.intercellSpacing = NSSize(width: 0.0, height: 10.0) // Matches the look and feel of Big Sur onwards.
        return comboBox
    }
    

    func updateNSView(_ nsView: NSComboBox, context: Context)
    {
        nsView.removeAllItems()
        nsView.addItems(withObjectValues: items)
        
        // ComboBox doesn't automatically select the item matching its text; we must do that manually. But we need the delegate to ignore that selection-change or we'll get a "state modified during view update; will cause undefined behavior" warning.
        context.coordinator.ignoreSelectionChanges = true
        context.coordinator.textVal = $text
        nsView.stringValue = text
        nsView.selectItem(withObjectValue: text)
        context.coordinator.ignoreSelectionChanges = false
    }
}

extension ComboBox
{
    class Coordinator: NSObject, NSComboBoxDelegate
    {
        var parent: ComboBox
        var ignoreSelectionChanges: Bool = false
        var textVal: Binding<String>
        
        init(_ parent: ComboBox, textV: Binding<String>) {
            self.parent = parent
            textVal = textV
        }
        

        func comboBoxSelectionDidChange(_ notification: Notification)
        {
            if !ignoreSelectionChanges,
               let box: NSComboBox = notification.object as? NSComboBox,
               let newStringValue: String = box.objectValueOfSelectedItem as? String
            {
                textVal.wrappedValue = newStringValue
            }
        }
        
        
        func controlTextDidEndEditing(_ obj: Notification)
        {
            if let textField = obj.object as? NSTextField
            {
                textVal.wrappedValue = textField.stringValue
            }
        }
    }
}
