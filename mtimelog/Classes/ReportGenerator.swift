//
//  ReportGenerator.swift
//  mtimelog
//
//  Created by David Battefeld on 27.10.23.
//

import Foundation
import SwiftUI

class ReportGenerator {
    @AppStorage("reportEmailRecipient") var reportEmailRecipient = ""
    @AppStorage("reportEmailFormat") var reportEmailFormat = ReportEmailFormat
        .plainText
    let workday: Workday
    let includeDuration: Bool
    let emailService = EmailService()

    init(workday: Workday, includeDuration: Bool) {
        self.workday = workday
        self.includeDuration = includeDuration
    }

    public func generateReport() -> String {
        switch reportEmailFormat {
        case .plainText:
            return generatePlainTextReport()
        case .html:
            return generateHTMLReport()
        }
    }
    
    public func sendReportEmailDirectly() {
        let emailSubject = emailService.formatDateForEmailSubject(date: workday.date)
        emailService.sendEmail(to: [reportEmailRecipient], subject: emailSubject, message: generateReport())
    }

    private func generatePlainTextReport() -> String {
        var fullReport =
            "Status for Working Day \(workday.date.formatted(date: .numeric, time: .omitted))\n\n"

        for task in workday.tasks where task.status != .ongoing {
            let taskReport = reportSingleTask(task: task)
            fullReport.append(taskReport)
            // multiline strings trim whitespace, so add line break manually
            fullReport.append("\n\n")
        }
        return fullReport
    }
    
    private func generateHTMLReport() -> String {
        let dateString = workday.date.formatted(date: .numeric, time: .omitted)

        var html = """
        <html>
        <head>
          <style>
            body {
              font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
              background-color: #f2f2f7;
              padding: 16px;
            }
            .container {
              max-width: 800px;
              margin: auto;
              background-color: white;
              border-radius: 12px;
              padding: 16px;
              box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            }
            h2 {
              font-size: 18px;
              margin-top: 0;
              margin-bottom: 16px;
              color: #111;
            }
            table {
              width: 100%;
              border-collapse: separate;
              border-spacing: 0;
              border-radius: 12px;
              overflow: hidden;
              border: 1px solid #ddd;
            }
            thead {
              background-color: #f9f9f9;
            }
            th, td {
              text-align: left;
              padding: 12px 8px;
              font-size: 15px;
            }
            th {
              font-weight: 600;
              color: #333;
              background-color: #f4f4f4;
            }
            td {
              color: #444;
              vertical-align: top;
              background-color: #fff;
            }
            tr:nth-child(even) td {
              background-color: #fafafa;
            }
            .status {
              white-space: nowrap;
            }

            /* DARK MODE SUPPORT */
            @media (prefers-color-scheme: dark) {
              body {
                background-color: #000;
              }
              .container {
                background-color: #1c1c1e;
                color: #fff;
                box-shadow: none;
              }
              h2 {
                color: #fff;
              }
              table {
                border: 1px solid #333;
              }
              thead {
                background-color: #2c2c2e;
              }
              th {
                background-color: #2c2c2e;
                color: #f2f2f2;
              }
              td {
                background-color: #1c1c1e;
                color: #ddd;
              }
              tr:nth-child(even) td {
                background-color: #2a2a2c;
              }
            }
          </style>
        </head>
        <body>
          <div class="container">
            <h2>Status for Working Day \(dateString)</h2>
            <table>
              <thead>
                <tr>
                  <th>Project</th>
                  <th>Description</th>
        """

        if includeDuration {
            html += "<th>Duration</th>"
        }

        html += """
                  <th>Status</th>
                  <th>Comment</th>
                </tr>
              </thead>
              <tbody>
        """

        for task in workday.tasks where task.status != .ongoing {
            html += "<tr>"
            html += "<td>\(task.projectID)</td>"
            html += "<td>\(task.taskDescription ?? "")</td>"

            if includeDuration {
                html += "<td>\(task.getDurationDataForExport())</td>"
            }

            html += "<td class=\"status\">\(task.status.emoji) \(task.status)</td>"

            let comment = (task.statusComment?.isEmpty == false) ? task.statusComment! : ""
            html += "<td>\(comment)</td>"

            html += "</tr>"
        }

        html += """
              </tbody>
            </table>
          </div>
        </body>
        </html>
        """

        return html
    }

    private func reportSingleTask(task: Task) -> String {
        return """
            \(task.projectID):

            - \(task.taskDescription ?? "")

            \(includeDuration ? task.getDurationDataForExport() : "")
            Status:
            \(task.status.emoji) \(task.status)
            \(includeStatusComment(task: task))
            _____________________________________________________
            """
    }

    private func includeStatusComment(task: Task) -> String {
        if let statusComment = task.statusComment {
            if !statusComment.isEmpty {
                return """
                    Comment:
                    \(task.statusComment ?? "")
                    """
            }
        }
        return ""
    }
}
