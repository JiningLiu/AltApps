//
//  ReportView.swift
//  ReportView
//
//  Created by JingJing on 8/14/21.
//

import SwiftUI
import MessageUI

struct ReportView: View {
    @State var reportedIssue = ""
    @State private var issueDefault = 0
    @State private var showMailView = false
    var issueOptions = ["Yes", "No", "Maybe"]
    var body: some View {
        Form {
            Section("ISSUE INFORMATION") {
                VStack {
                    Text("Is the issue a bug?")
                        .padding(.top, 5)
                    Picker(selection: $issueDefault, label: Text("Is the issue a bug?")) {
                        ForEach(0 ..< issueOptions.count) {
                            Text(self.issueOptions[$0])
                        }
                    }
                        .pickerStyle(SegmentedPickerStyle())
                }
                TextField("Describe the issue here", text: $reportedIssue)
                Text("You can upload screenshots as attachments in this Email.")
            }
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
