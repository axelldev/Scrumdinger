//
//  DetailEditview.swift
//  Scrumdinger
//
//  Created by axell solis on 05/09/25.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var scrum: DailyScrum
    @State private var attendeeName = ""

    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $scrum.title)

                HStack {
                    Slider(value: $scrum.lengthInMinutesAsDouble, in: 5...30, step: 1) {
                        Text("Length")
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes) minutes")

                    Spacer()

                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityHidden(true)
                }
                
                ThemePicker(selection: $scrum.theme)
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
    @Previewable @State var scrum = DailyScrum.emptyScrum
    VStack {
        Text(scrum.title)
        DetailEditView(scrum: $scrum)
    }
}
