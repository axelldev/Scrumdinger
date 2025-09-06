//
//  DetailEditview.swift
//  Scrumdinger
//
//  Created by axell solis on 05/09/25.
//

import SwiftUI

struct DetailEditView: View {
    @State private var scrum = DailyScrum.emptyScrum
    @State private var attendeeName = ""

    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $scrum.title)

                HStack {
                    Slider(value: $scrum.lengthInMinutesAsDouble) {
                        Text("Length")
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes) minutes")

                    Spacer()

                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityHidden(true)
                }
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
                            let attendee = DailyScrum.Attendee(
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
    }
}

#Preview {
    DetailEditView()
}
