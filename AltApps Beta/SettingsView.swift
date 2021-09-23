//
//  SettingsView.swift
//  SettingsView
//
//  Created by JingJing on 8/5/21.
//

import SwiftUI

struct ComposeMailData {
  let subject: String
  let recipients: [String]?
  let message: String
}

struct SettingsView: View {
    @State var viewStyleChangerSettingsView = UserDefaults.standard.showFeaturedView
    @State var refreshImages = UserDefaults.standard.refreshImagesToggle
    @State private var mailData = ComposeMailData(subject: "Contact Us",
                                                    recipients: ["altappsapp@gmail.com"],
                                                    message: "")
    @State private var showMailView = false
    @State private var resetAppAlert = false
    @State private var resetApp = false
    @State private var reloadAlert = false
    @State private var reinstallAlert = false
    @State var submitApp = false
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) var openURL
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Text(UIDevice.current.localizedModel)
                        Spacer()
                        Text(UIDevice.current.systemName + " " + UIDevice.current.systemVersion)
                    }
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.2.0-beta")
                    }
                }
                Section {
                    if viewStyleChangerSettingsView == 0 {
                        HStack {
                            Button("Featured View") {
                                UserDefaults.standard.showFeaturedView = 0
                                viewStyleChangerSettingsView = 0
                            }
                                .foregroundColor(Color.mainColor)
                            Spacer()
                            Image(systemName: "checkmark")
                                .foregroundColor(Color.mainColor)
                        }
                        Button("List View") {
                            UserDefaults.standard.showFeaturedView = 1
                            reloadAlert = true
                            viewStyleChangerSettingsView = 1
                        }
                        .foregroundColor(Color.blue)
                        .alert("View Style Changed", isPresented: $reloadAlert) {
                            Button("OK", role: .cancel) {
                                reloadAlert = false
                                print("View Style Changed")
                            }
                        }
                    } else {
                        Button("Featured View") {
                            UserDefaults.standard.showFeaturedView = 0
                            reloadAlert = true
                            viewStyleChangerSettingsView = 0
                        }
                        .alert("View Style Changed", isPresented: $reloadAlert) {
                            Button("OK", role: .cancel) {
                                reloadAlert = false
                                print("View Style Changed")
                            }
                        }
                        .foregroundColor(Color.blue)
                        HStack {
                            Button("List View") {
                                UserDefaults.standard.showFeaturedView = 1
                                viewStyleChangerSettingsView = 1
                            }
                                .foregroundColor(Color.mainColor)
                            Spacer()
                            Image(systemName: "checkmark")
                                .foregroundColor(Color.mainColor)
                        }
                    }
                    HStack {
                        if refreshImages {
                            Button("Refresh Images") {
                                if refreshImages {
                                    refreshImages = false
                                    UserDefaults.standard.refreshImagesToggle = false
                                } else {
                                    refreshImages = true
                                    UserDefaults.standard.refreshImagesToggle = true
                                }
                            }
                                .foregroundColor(Color.mainColor)
                        } else {
                            Button("Refresh Images") {
                                if refreshImages {
                                    refreshImages = false
                                    UserDefaults.standard.refreshImagesToggle = false
                                } else {
                                    refreshImages = true
                                    UserDefaults.standard.refreshImagesToggle = true
                                }
                            }
                                .foregroundColor(Color.blue)
                        }
                        Spacer()
                        if refreshImages {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color.mainColor)
                        }
                    }
                }
                Section {
                    Button("Contact Us") {
                        showMailView.toggle()
                    }
                    .disabled(!MailView.canSendMail)
                    .sheet(isPresented: $showMailView) {
                        NavigationView {
                            List {
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                    submitApp = true
                                }, label: {
                                    HStack {
                                        Image(systemName: "square.and.arrow.up")
                                        Text("Submit/Suggest an App")
                                    }
                                })
                            }
                        }
                    }
                  .sheet(isPresented: $submitApp) {
                       // Webview w/ link https://4ohyds73uh6.typeform.com/to/j1VxaKM1
                  }
                }
                Section(footer: Text("©2021 AltApps, all rights reserved")) {
                    Button("Reset All Settings", role: .destructive) {
                        resetAppAlert = true
                    }
                    .alert("Reset All Settings?", isPresented: $resetAppAlert) {
                        Button("Yes", role: .destructive) {
                            UserDefaults.standard.showFeaturedView = 0
                            UserDefaults.standard.refreshImagesToggle = true
                            UserDefaults.standard.showWelcomeScreen = true
                            UserDefaults.standard.previousVersion = "noResults"
                            UserDefaults.standard.showUpdate = false
                            resetApp = true
                            resetAppAlert = false
                        }
                        Button("No", role: .cancel) {
                            print("Quit Action Canceled")
                        }
                    }
                    .alert("Restart AltApps to continue", isPresented: $resetApp) {
                        Button("Quit AltApps", role: .destructive) {
                            resetApp = false
                            exit(0)
                        }
                        Button("Later", role: .cancel) {
                            print("Quit Action Canceled")
                        }
                    }
                    Button("Reinstall AltApps", role: .destructive) {
                        reinstallAlert = true
                    }
                    .alert("Reinstall AltApps w/ AltStore?", isPresented: $reinstallAlert) {
                        Button("Yes", role: .destructive) {
                            openURL(URL(string: "altstore://install?url=https://rebrand.ly/altapps_beta_install")!)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
