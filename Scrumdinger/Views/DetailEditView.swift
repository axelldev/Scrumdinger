//
//  DetailEditview.swift
//  Scrumdinger
//
//  Created by axell solis on 05/09/25.
//

import SwiftData
import SwiftUI
import ThemeKit

struct DetailEditView: View {
    let scrum: DailyScrum

    @State private var attendeeName = ""
    @State private var title: String
    @State private var lengthInMinutesAsDouble: Double
    @State private var attendees: [Attendee]
    @State private var theme: Theme
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    private var lengthInMinutes: String {
        String(format: "%.0f", lengthInMinutesAsDouble)
    }

    private let isCreatingScrum: Bool

    init(scrum: DailyScrum? = nil) {
        let scrumToEdit: DailyScrum
        if let scrum {
            scrumToEdit = scrum
            isCreatingScrum = false
        } else {
            scrumToEdit = DailyScrum(
                title: "",
                attendees: [],
                lengthInMinutes: 5,
                theme: .sky
            )
            isCreatingScrum = true
        }

        self.scrum = scrumToEdit
        self.title = scrumToEdit.title
        self.lengthInMinutesAsDouble = scrumToEdit.lengthInMinutesAsDouble
        self.attendees = scrumToEdit.attendees
        self.theme = scrumToEdit.theme
    }

    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $title)

                HStack {
                    Slider(
                        value: $lengthInMinutesAsDouble,
                        in: 5...30,
                        step: 1
                    ) {
                        Text("Length")
                    }
                    .accessibilityValue("\(lengthInMinutes) minutes")

                    Spacer()

                    Text("\(lengthInMinutes) minutes")
                        .accessibilityHidden(true)
                }

                ThemePicker(selection: $theme)
            }

            Section("Attendees") {
                ForEach(scrum.attendees) { attende in
                    Text(attende.name)
                }
                .onDelete { indices in
                    scrum.attendees.remove(atOffsets: indices)
                }

                HStack {
                    TextField("New attendee", text: $attendeeName)
                    Button {
                        withAnimation {
                            let attendee = Attendee(
                                name: attendeeName
                            )
                            scrum.attendees.append(attendee)
                            attendeeName = ""
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(attendeeName.trimmed().isEmpty)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }

            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    saveEdits()
                    dismiss()
                }
            }
        }
    }

    private func saveEdits() {
        scrum.title = title
        scrum.lengthInMinutesAsDouble = lengthInMinutesAsDouble
        scrum.attendees = attendees
        scrum.theme = theme

        if isCreatingScrum {
            context.insert(scrum)
        }

        try? context.save()
    }
}

#Preview(traits: .dailyScrumsSampleData) {
    @Previewable @Query(sort: \DailyScrum.title) var scrums: [DailyScrum]
    DetailEditView(scrum: scrums[0])
}
