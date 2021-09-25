//
//  SettingsView.swift
//  SettingsView
//
//  Created by JingJing on 8/5/21.
//

import SwiftUI

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

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
    @State var showSafari = false
    @State var showSafari2 = false
    @State var showSafari3 = false
    @State var showSafari4 = false
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
                    .sheet(isPresented: $showMailView) {
                        NavigationView {
                            List {
                                Group {
                                    Button(action: {
                                        showSafari.toggle()
                                    }, label: {
                                        HStack {
                                            Image(systemName: "square.and.arrow.up")
                                            Text("Submit/Suggest an App")
                                        }
                                    })
                                    .foregroundColor(.mainColor)
                                    .sheet(isPresented: $showSafari) {
                                        SFSafariViewWrapper(url: URL(string: "https://4ohyds73uh6.typeform.com/to/j1VxaKM1")!)
                                            .ignoresSafeArea()
                                    }
                                    Button(action: {
                                        showSafari2.toggle()
                                    }, label: {
                                        HStack {
                                            Image(systemName: "exclamationmark.bubble")
                                            Text("Report a Bug")
                                        }
                                    })
                                    .foregroundColor(.mainColor)
                                    .sheet(isPresented: $showSafari2) {
                                        SFSafariViewWrapper(url: URL(string: "https://4ohyds73uh6.typeform.com/to/UCmU799C")!)
                                            .ignoresSafeArea()
                                    }
                                    Button(action: {
                                        showSafari3.toggle()
                                    }, label: {
                                        HStack {
                                            Image(systemName: "ellipsis.circle")
                                            Text("Tell Us Something Else")
                                        }
                                    })
                                    .foregroundColor(.mainColor)
                                    .sheet(isPresented: $showSafari3) {
                                        SFSafariViewWrapper(url: URL(string: "https://4ohyds73uh6.typeform.com/to/bwZWngco")!)
                                            .ignoresSafeArea()
                                    }
                                }
                                Button(action: {
                                    showSafari4.toggle()
                                }, label: {
                                    HStack {
                                        Image(systemName: "dollarsign.circle")
                                        Text("Donate")
                                    }
                                })
                                .foregroundColor(.mainColor)
                                .sheet(isPresented: $showSafari4) {
                                    SFSafariViewWrapper(url: URL(string: "https://www.buymeacoffee.com/altapps")!)
                                        .ignoresSafeArea()
                                }
                            }
                            .navigationBarItems(leading: Button("Done") {showMailView = false})
                            .navigationBarTitle("Contact Us")
                        }
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
