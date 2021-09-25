//
//  AddCustomAppView.swift
//  AddCustomAppView
//
//  Created by JingJing on 8/5/21.
//

import SwiftUI
import UIKit

struct AddCustomAppView: View {
    @State private var customInstallLink: String = ""
    @Environment(\.openURL) var openURL
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            HStack {
                Spacer()
                TextField("Enter direct download link here", text: $customInstallLink)
                    .textFieldStyle(.roundedBorder)
                Spacer()
                Button("INSTALL") {
                    openURL(URL(string: "altstore://install?url=\(customInstallLink)")!)
                    Haptics.shared.play(.light)
                }
                    .buttonStyle(installButton())
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Install other apps", displayMode: .inline)
        }
    }
}

struct AddCustomAppView_Previews: PreviewProvider {
    static var previews: some View {
        AddCustomAppView()
    }
}