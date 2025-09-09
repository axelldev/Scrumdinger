//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by axell solis on 02/09/25.
//
import SwiftUI
import ThemeKit

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @State private var isPresentingNewScrumView = false

    var body: some View {
        NavigationStack {
            List($scrums) { $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button {
                    isPresentingNewScrumView = true
                } label:  {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New scrum")
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NewScrumSheet(scrums: $scrums)
        }
    }
}

#Preview {
    @Previewable @State var scrums = DailyScrum.sampleData
    ScrumsView(scrums: $scrums)
}
