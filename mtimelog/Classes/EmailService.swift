//
//  EmailService.swift
//  mtimelog
//
//  Created by David Battefeld on 13.07.25.
//

import AppKit
import Foundation

class EmailService {
    let formatter = DateFormatter()

    /// Send an email directly via macOS sharing framework, bypassing the app selection screen.
    public func sendEmail(to: [String], subject: String, message: String) {
        let service = NSSharingService(named: .composeEmail)!
        service.recipients = to
        service.subject = subject

        /// Several tutorials include a conversion to `NSAttributedString` here, but in this case the HTML works better without it
        service.perform(withItems: [message])
    }

    public func formatDateForEmailSubject(date: Date) -> String {
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = formatter.string(from: date)
        return "[status][\(formattedDate)]"
    }

}
