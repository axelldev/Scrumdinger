//
//  DetailEditview.swift
//  Scrumdinger
//
//  Created by axell solis on 05/09/25.
//

import SwiftUI

struct DetailEditView: View {
    @State private var scrum = DailyScrum.emptyScrum
    
    
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $scrum.title)
                
                HStack {
                    Slider(value: $scrum.lengthInMinutesAsDouble) {
                        Text("Length")
                    }
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
            }
            
            Section("Attendees") {
                ForEach(scrum.attendees) { attende in
                    Text(attende.name)
                }
            }
        }
    }
}

#Preview {
   DetailEditView()
}
