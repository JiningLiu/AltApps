//
//  SettingsView.swift
//  SettingsView
//
//  Created by JingJing on 8/5/21.
//

import SwiftUI

struct AltAppsUpdateResponse: Codable {
    var AltAppsRawResults: [AltAppsUpdateResult]
}

struct AltAppsUpdateResult: Codable {
    var UpdateAppID: Int
    var AltAppsVersion: String
    var AltAppsLink: String
}

struct ComposeMailData {
  let subject: String
  let recipients: [String]?
  let message: String
}

struct SettingsView: View {
    @State var AltAppsRawResults = [AltAppsUpdateResult]()
    @State var viewStyleChangerSettingsView = UserDefaults.standard.showFeaturedView
    @State var refreshImages = UserDefaults.standard.refreshImagesToggle
    @State private var mailData = ComposeMailData(subject: "Contact Us",
                                                    recipients: ["jingjingbigbrain@icloud.com"],
                                                    message: "")
    @State private var showMailView = false
    @State private var resetAppAlert = false
    @State private var resetApp = false
    @State private var reloadAlert = false
    @State private var reinstallAlert = false
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) var openURL
    var body: some View {
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
                ForEach(AltAppsRawResults, id: \.UpdateAppID) { item1 in
                    if item1.AltAppsVersion == "v1.2.0-beta" {
                        HStack {
                            Text("AltApps is Up to Date")
                                .foregroundColor(Color.green)
                            Spacer()
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(Color.green)
                        }
                    } else {
                        Button("Install New Update (\(item1.AltAppsVersion))") {
                            openURL(URL(string: item1.AltAppsLink)!)
                        }
                    }
                }
            }
            Section {
                if viewStyleChangerSettingsView == 0 {
                    HStack {
                        Button("Featured View") {
                            UserDefaults.standard.showFeaturedView = 0
                            viewStyleChangerSettingsView = 0
                        }
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
                    MailView(data: $mailData) { result in
                        print(result)
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
                        UserDefaults.standard.showWelcomeScreen = true
                        UserDefaults.standard.refreshImagesToggle = true
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
        .onAppear(perform: AltAppsUpdateLoadData)
        .navigationBarTitle("Settings")
    }
    func AltAppsUpdateLoadData() {
        guard let url = URL(string: "https://rebrand.ly/altapps_1-2-0-beta1_update") else {
            print("Invalid URL")
            return
        }
        let request1 = URLRequest(url: url)
        URLSession.shared.dataTask(with: request1) { data2, response2, error2 in
            if let data2 = data2 {
                if let decodedResponse2 = try? JSONDecoder().decode(AltAppsUpdateResponse.self, from: data2) {
                    DispatchQueue.main.async {
                        AltAppsRawResults = decodedResponse2.AltAppsRawResults
                    }
                    return
                }
            }
            print("Fetch failed: \(error2?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
