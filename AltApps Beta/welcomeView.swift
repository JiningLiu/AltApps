//
//  welcomeView.swift
//  welcomeView
//
//  Created by JingJing on 8/3/21.
//

import SwiftUI

extension UserDefaults {
    var welcomeScreenShown: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "welcomeScreenShown") as? Bool) ?? false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "welcomeScreenShown")
        }
    }
}

extension UserDefaults {
    var showFeaturedView: Int {
        get {
            return (UserDefaults.standard.value(forKey: "showFeaturedView") as? Int) ?? 1
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "showFeaturedView")
        }
    }
}

struct welcomeView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var viewStyle = UserDefaults.standard.showFeaturedView
    @State var refreshImagesWelcome = UserDefaults.standard.refreshImagesToggle
    var stylePreview = ""
    var stylePicker = ["Featured", "List"]
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Spacer()
                    HStack {
                        Image("AltAppsIcon")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16.5)
                            .frame(width: 75, height: 75, alignment: .center)
                            .shadow(radius: 5)
                        Spacer()
                        VStack {
                            Text("Welcome to")
                                .customTitleText()
                            Text("AltApps")
                                .customTitleText()
                                .foregroundColor(.mainColor)
                        }
                    }
                        .padding(.horizontal)
                    VStack(alignment: .leading) {
                        InformationDetailView(title: "Apps", subTitle: "AltApps provides tweaked, original, and jailbreaking apps for AltStore users, for free.", imageName: "square.stack")
                        InformationDetailView(title: "Updates", subTitle: "With constant updates, AltApps will give you the best user experience without revokes.", imageName: "square.and.arrow.up")
                        InformationDetailView(title: "Simple", subTitle: "AltApps is easy to use, no ads, just like the App Store, no need to worry.", imageName: "checkmark.square")
                    }
                Spacer()
                NavigationLink(
                    destination: {
                        VStack {
                            Text("Choose A Style")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.mainColor)
                            if viewStyle == 0 {
                                Image("FeaturedViewPreview")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, alignment: .center)
                                    .padding()
                            } else {
                                Image("ListViewPreview")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, alignment: .center)
                                    .padding()
                            }
                            HStack {
                                if viewStyle == 0 {
                                    Button(action: {viewStyle = 0; UserDefaults.standard.showFeaturedView = 0}, label: {Text("Featured").foregroundColor(Color.mainColor)}).buttonStyle(.bordered).padding()
                                    Button(action: {viewStyle = 1; UserDefaults.standard.showFeaturedView = 1}, label: {Text("List")}).buttonStyle(.bordered).padding()
                                } else {
                                    Button(action: {viewStyle = 0; UserDefaults.standard.showFeaturedView = 0}, label: {Text("Featured")}).buttonStyle(.bordered).padding()
                                    Button(action: {viewStyle = 1; UserDefaults.standard.showFeaturedView = 1}, label: {Text("List").foregroundColor(Color.mainColor)}).buttonStyle(.bordered).padding()
                                }
                            }
                        }
                        Spacer()
                        Button(action: {UserDefaults.standard.showWelcomeScreen = false; presentationMode.wrappedValue.dismiss()}) {
                            Text("Finish Setup")
                                .customButtonSmall()
                        }.padding(.horizontal)
                        NavigationLink(destination: {
                            VStack {
                                Text("Advanced Options")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.mainColor)
                                    .padding(.bottom)
                                if refreshImagesWelcome {
                                    Button(action: {refreshImagesWelcome = false; UserDefaults.standard.refreshImagesToggle = false}) {
                                        HStack {
                                            Text("Refresh Images")
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                        .foregroundColor(Color.mainColor)
                                        .buttonStyle(.bordered)
                                } else {
                                    Button(action: {refreshImagesWelcome = true; UserDefaults.standard.refreshImagesToggle = true}) {
                                        HStack {
                                            Text("Refresh Images")
                                        }
                                    }
                                        .buttonStyle(.bordered)
                                }
                            }
                            .navigationBarTitle("", displayMode: .inline)
                        }) {
                            Text("Advanced Options")
                                .foregroundColor(Color.blue)
                        }
                    }) {
                            Text("Continue")
                                .customButtonSmall()
                        }
            }
                .padding(.horizontal)
                .navigationTitle("Back")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
        .interactiveDismissDisabled()
    }
}
        
struct welcomeView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            welcomeView().preferredColorScheme($0)
        }
    }
}
