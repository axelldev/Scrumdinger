//
//  Untitled.swift
//  Scrumdinger
//
//  Created by axell solis on 08/09/25.
//

import Foundation
import SwiftData

@Model
class History: Identifiable {
    var id: UUID
    var date: Date
    var atteedees: [Attendee]
    var dailyScrum: DailyScrum?

    init(
        id: UUID = UUID(),
        date: Date = Date(),
        attendees: [Attendee]
    ) {
        self.id = id
        self.date = date
        self.atteedees = attendees
    }
}
