//
//  Untitled.swift
//  Scrumdinger
//
//  Created by axell solis on 08/09/25.
//

import Foundation

struct History: Identifiable {
    let id: UUID
    let date: Date
    var atteedees: [DailyScrum.Attendee]

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
