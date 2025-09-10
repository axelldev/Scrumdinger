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
    var atteedees: [DailyScrum.Attendee]
    var dailyScrum: DailyScrum?

    init(
        id: UUID = UUID(),
        date: Date = Date(),
        attendees: [DailyScrum.Attendee]
    ) {
        self.id = id
        self.date = date
        self.atteedees = attendees
    }
}
