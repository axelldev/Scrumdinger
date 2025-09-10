//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by axell solis on 31/08/25.
//

import SwiftUI
import SwiftData

@main
struct ScrumdingerApp: App {
    var body: some Scene {
        WindowGroup {
            ScrumsView()
        }
        .modelContainer(for: DailyScrum.self)
    }
}
