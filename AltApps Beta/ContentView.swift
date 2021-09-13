//
//  ContentView.swift
//  AltApps Beta
//
//  Created by JingJing on 8/3/21.
//

import SwiftUI
import UIKit
import DispatchIntrospection

struct listResponse: Codable {
    var appResults: [listResult]
}

struct listResult: Codable {
    var appID: Int
    var appListName: String
    var appVersion: String
    var installLink: String
    var imageLink: String
    var appDetail: String
}

struct appOfTheDayResponse: Codable {
    var aotdResult: [AOTDresult]
}

struct AOTDresult: Codable {
    var AOTDid: Int
    var AOTDname: String
    var AOTDinstall: String
    var AOTDimage: String
}

struct jailbreakResponse: Codable {
    var jailbreakResults: [jailbreakResult]
}

struct jailbreakResult: Codable {
    var jailbreakID: Int
    var jailbreakName: String
    var jailbreakVersion: String
    var jailbreakLink: String
    var jailbreakImage: String
    var jailbreakDetail: String
}

struct tweakResponse: Codable {
    var tweakResults: [tweakResult]
}

struct tweakResult: Codable {
    var tweakID: Int
    var tweakName: String
    var tweakVersion: String
    var tweakLink: String
    var tweakImage: String
    var tweakDetail: String
}

struct otherResponse: Codable {
    var otherResults: [otherResult]
}

struct otherResult: Codable {
    var otherID: Int
    var otherName: String
    var otherVersion: String
    var otherLink: String
    var otherImage: String
    var otherDetail: String
}

struct AltAppsUpdateResponse: Codable {
    var AltAppsRawResults: [AltAppsUpdateResult]
}

struct AltAppsUpdateResult: Codable {
    var UpdateAppID: Int
    var AltAppsVersion: String
    var AltAppsLink: String
}

extension UserDefaults {
    var showWelcomeScreen: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "showWelcomeScreen") as? Bool) ?? true
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "showWelcomeScreen")
        }
    }
}

extension UserDefaults {
    var refreshImagesToggle: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "refreshImagesToggle") as? Bool) ?? true
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "refreshImagesToggle")
        }
    }
}

extension Color {
    static var randomColor: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
            .mask(self)
    }
}

class Haptics {
    static let shared = Haptics()
    
    private init() { }

    func play(_ feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: feedbackStyle).impactOccurred()
    }
    
    func notify(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(feedbackType)
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Text {
    func customTitleText() -> Text {
        self
            .fontWeight(.black)
            .font(.system(size: 36))
    }
}

extension Color {
    static var mainColor = Color(UIColor.systemIndigo)
}


struct ContentView: View {
    @State private var isViewLoading = false
    @State var appResults = [listResult]()
    @State var aotdResult = [AOTDresult]()
    @State var jailbreakResults = [jailbreakResult]()
    @State var tweakResults = [tweakResult]()
    @State var otherResults = [otherResult]()
    @State var AltAppsRawResults = [AltAppsUpdateResult]()
    @State var showWelcomeView = UserDefaults.standard.showWelcomeScreen
    @State var reloadImages = 0
    @State var showAddAppView = false
    @State var showSettingsView = false
    @State var updateAvailable = true
    @Environment(\.openURL) var openURL
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    if UserDefaults.standard.showFeaturedView == 0 {
                        List {
                            VStack {
                                ScrollView {
                                    ForEach(AltAppsRawResults, id: \.UpdateAppID) { item1 in
                                        if item1.AltAppsVersion != "v1.2.0-beta" {
                                            HStack {
                                                Text("Update Available")
                                                    .font(.title)
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(Color.mainColor)
                                                    .padding(.horizontal)
                                                Spacer()
                                            }
                                            VStack {
                                                HStack {
                                                    Spacer()
                                                    Image("AltAppsIcon")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .cornerRadius(15.4)
                                                        .frame(width: 70, height: 70, alignment: .center)
                                                        .shadow(radius: 5)
                                                        .padding(EdgeInsets(top: 7.5, leading: 0, bottom: 5, trailing: 0))
                                                    Spacer()
                                                }
                                                Text("AltApps \(item1.AltAppsVersion)")
                                                    .foregroundColor(Color.white)
                                                    .fontWeight(.semibold)
                                                Button("INSTALL") {
                                                    openURL(URL(string: item1.AltAppsLink)!)
                                                    Haptics.shared.play(.light)
                                                }
                                                    .buttonStyle(installButton())
                                                    .padding(.bottom, 7.5)
                                            }
                                            .padding(.vertical, 10)
                                            .background(Color.mainColor)
                                            .clipShape(RoundedRectangle(cornerRadius: 25))
                                            .frame(maxWidth: .infinity)
                                            .padding(.horizontal)
                                            .padding(.bottom, 5)
                                        }
                                    }
                                    HStack {
                                        Text("App of The Week")
                                            .font(.title)
                                            .fontWeight(.semibold)
                                            .gradientForeground(colors: [.red, .yellow])
                                            .padding(.horizontal)
                                        Spacer()
                                    }
                                    ForEach(aotdResult, id: \.AOTDid) { item2 in
                                        VStack {
                                            HStack {
                                                Spacer()
                                                if reloadImages == 0 {
                                                    AsyncImage(url: URL(string: item2.AOTDimage)) { aotdAppImage in
                                                        aotdAppImage
                                                            .resizable()
                                                            .scaledToFit()
                                                            .cornerRadius(15.4)
                                                            .frame(width: 70, height: 70, alignment: .center)
                                                            .shadow(radius: 5)
                                                    } placeholder: {
                                                        Image(systemName: "app.fill")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .cornerRadius(15.4)
                                                            .frame(width: 70, height: 70, alignment: .center)
                                                            .shadow(radius: 5)
                                                            .foregroundColor(Color.randomColor)
                                                    }
                                                    .padding(EdgeInsets(top: 7.5, leading: 0, bottom: 5, trailing: 0))
                                                } else {
                                                    AsyncImage(url: URL(string: item2.AOTDimage)) { aotdAppImage in
                                                        aotdAppImage
                                                            .resizable()
                                                            .scaledToFit()
                                                            .cornerRadius(15.4)
                                                            .frame(width: 70, height: 70, alignment: .center)
                                                            .shadow(radius: 5)
                                                    } placeholder: {
                                                        Image(systemName: "app.fill")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .cornerRadius(15.4)
                                                            .frame(width: 70, height: 70, alignment: .center)
                                                            .shadow(radius: 5)
                                                            .foregroundColor(Color.randomColor)
                                                    }
                                                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                                }
                                                Spacer()
                                            }
                                            Text(item2.AOTDname)
                                                .foregroundColor(Color.white)
                                                .fontWeight(.semibold)
                                            Button("INSTALL") {
                                                openURL(URL(string: item2.AOTDinstall)!)
                                                Haptics.shared.play(.light)
                                            }
                                                .buttonStyle(installButton())
                                                .padding(.bottom, 7.5)
                                        }
                                        .padding(.vertical, 10)
                                    }
                                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.yellow]), startPoint: .leading, endPoint: .trailing))
                                        .clipShape(RoundedRectangle(cornerRadius: 25))
                                        .frame(maxWidth: .infinity)
                                        .padding(.horizontal)
                                        .padding(.bottom, 5)
                                    HStack {
                                        Text("Jailbreak")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            .gradientForeground(colors: [.teal, .green])
                                            .padding(.horizontal)
                                            .padding(.bottom, 5)
                                        Spacer()
                                    }
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            ForEach(jailbreakResults, id: \.jailbreakID) { item3 in
                                                ZStack {
                                                    Image(systemName: "square.fill")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .foregroundColor(Color.clear)
                                                        .background(LinearGradient(gradient: Gradient(colors: [Color.teal, Color.green]), startPoint: .leading, endPoint: .trailing))
                                                        .clipShape(RoundedRectangle(cornerRadius: 18))
                                                        .frame(width: 175, height: 175)
                                                        .padding()
                                                        .shadow(radius: 5)
                                                    VStack {
                                                        NavigationLink(destination:
                                                            HStack {
                                                                VStack {
                                                                    AsyncImage(url: URL(string: item3.jailbreakImage)) { jailbreakImage1 in
                                                                        jailbreakImage1
                                                                            .resizable()
                                                                            .scaledToFit()
                                                                            .cornerRadius(14.3)
                                                                            .frame(width: 65, height: 65, alignment: .center)
                                                                            .shadow(radius: 5)
                                                                    } placeholder: {
                                                                        Image(systemName: "app.fill")
                                                                            .resizable()
                                                                            .scaledToFit()
                                                                            .cornerRadius(14.3)
                                                                            .frame(width: 65, height: 65, alignment: .center)
                                                                            .shadow(radius: 5)
                                                                            .foregroundColor(Color.randomColor)
                                                                    }
                                                                    Button("INSTALL") {
                                                                        openURL(URL(string: item3.jailbreakLink)!)
                                                                        Haptics.shared.play(.light)
                                                                    }
                                                                        .buttonStyle(installButton())
                                                                }
                                                                Text(item3.jailbreakDetail)
                                                            }
                                                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                                                        .navigationBarTitle("\(item3.jailbreakName) (\(item3.jailbreakVersion))", displayMode: .inline)) {
                                                            VStack {
                                                                if reloadImages == 0 {
                                                                    AsyncImage(url: URL(string: item3.jailbreakImage)) { appImage in
                                                                        appImage
                                                                            .resizable()
                                                                            .scaledToFit()
                                                                            .cornerRadius(14.3)
                                                                            .frame(width: 65, height: 65, alignment: .center)
                                                                            .shadow(radius: 5)
                                                                    } placeholder: {
                                                                        Image(systemName: "app.fill")
                                                                            .resizable()
                                                                            .scaledToFit()
                                                                            .cornerRadius(14.3)
                                                                            .frame(width: 65, height: 65, alignment: .center)
                                                                            .shadow(radius: 5)
                                                                            .foregroundColor(Color.randomColor)
                                                                    }
                                                                    .padding(.bottom, 5)
                                                                } else {
                                                                    AsyncImage(url: URL(string: item3.jailbreakImage)) { appImage in
                                                                        appImage
                                                                            .resizable()
                                                                            .scaledToFit()
                                                                            .cornerRadius(14.3)
                                                                            .frame(width: 65, height: 65, alignment: .center)
                                                                            .shadow(radius: 5)
                                                                    } placeholder: {
                                                                        Image(systemName: "app.fill")
                                                                            .resizable()
                                                                            .scaledToFit()
                                                                            .cornerRadius(14.3)
                                                                            .frame(width: 65, height: 65, alignment: .center)
                                                                            .shadow(radius: 5)
                                                                            .foregroundColor(Color.randomColor)
                                                                    }
                                                                    .padding(.bottom, 5)
                                                                }
                                                                Text("\(item3.jailbreakName)")
                                                                    .font(.title3)
                                                                    .fontWeight(.semibold)
                                                                    .foregroundColor(Color.mainColor)
                                                                    .padding(.bottom, 5)
                                                            }
                                                        }
                                                        Button("INSTALL") {
                                                            openURL(URL(string: item3.jailbreakLink)!)
                                                            Haptics.shared.play(.light)
                                                        }
                                                            .buttonStyle(installButton())
                                                    }
                                                }
                                            }
                                        }
                                    }
                                        .frame(height: 205)
                                        .background(LinearGradient(gradient: Gradient(colors: [Color.teal, Color.green]), startPoint: .leading, endPoint: .trailing))
                                        .clipShape(RoundedRectangle(cornerRadius: 30))
                                        .padding(.horizontal)
                                    HStack {
                                        Text("Tweaked Apps")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            .gradientForeground(colors: [.mint, .blue])
                                            .padding(.horizontal)
                                            .padding(.bottom, 5)
                                        Spacer()
                                    }
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            ForEach(tweakResults, id: \.tweakID) { item4 in
                                                ZStack {
                                                    Image(systemName: "square.fill")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .foregroundColor(Color.clear)
                                                        .background(LinearGradient(gradient: Gradient(colors: [Color.mint, Color.blue]), startPoint: .leading, endPoint: .trailing))
                                                        .clipShape(RoundedRectangle(cornerRadius: 18))
                                                        .frame(width: 175, height: 175)
                                                        .padding()
                                                        .shadow(radius: 5)
                                                    VStack {
                                                        NavigationLink(destination:
                                                            HStack {
                                                                VStack {
                                                                    AsyncImage(url: URL(string: item4.tweakImage)) { tweakImage1 in
                                                                        tweakImage1
                                                                            .resizable()
                                                                            .scaledToFit()
                                                                            .cornerRadius(14.3)
                                                                            .frame(width: 65, height: 65, alignment: .center)
                                                                            .shadow(radius: 5)
                                                                    } placeholder: {
                                                                        Image(systemName: "app.fill")
                                                                            .resizable()
                                                                            .scaledToFit()
                                                                            .cornerRadius(14.3)
                                                                            .frame(width: 65, height: 65, alignment: .center)
                                                                            .shadow(radius: 5)
                                                                            .foregroundColor(Color.randomColor)
                                                                    }
                                                                    Button("INSTALL") {
                                                                        openURL(URL(string: item4.tweakLink)!)
                                                                        Haptics.shared.play(.light)
                                                                    }
                                                                        .buttonStyle(installButton())
                                                                }
                                                                Text(item4.tweakDetail)
                                                            }
                                                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                                                        .navigationBarTitle("\(item4.tweakName) (\(item4.tweakVersion))", displayMode: .inline)) {
                                                            VStack {
                                                                if reloadImages == 0 {
                                                                    AsyncImage(url: URL(string: item4.tweakImage)) { tweakImage2 in
                                                                        tweakImage2
                                                                            .resizable()
                                                                            .scaledToFit()
                                                                            .cornerRadius(14.3)
                                                                            .frame(width: 65, height: 65, alignment: .center)
                                                                            .shadow(radius: 5)
                                                                    } placeholder: {
                                                                        Image(systemName: "app.fill")
                                                                            .resizable()
                                                                            .scaledToFit()
                                                                            .cornerRadius(14.3)
                                                                            .frame(width: 65, height: 65, alignment: .center)
                                                                            .shadow(radius: 5)
                                                                            .foregroundColor(Color.randomColor)
                                                                    }
                                                                } else {
                                                                    AsyncImage(url: URL(string: item4.tweakImage)) { tweakImage2 in
                                                                        tweakImage2
                                                                            .resizable()
                                                                            .scaledToFit()
                                                                            .cornerRadius(14.3)
                                                                            .frame(width: 65, height: 65, alignment: .center)
                                                                            .shadow(radius: 5)
                                                                    } placeholder: {
                                                                        Image(systemName: "app.fill")
                                                                            .resizable()
                                                                            .scaledToFit()
                                                                            .cornerRadius(14.3)
                                                                            .frame(width: 65, height: 65, alignment: .center)
                                                                            .shadow(radius: 5)
                                                                            .foregroundColor(Color.randomColor)
                                                                    }
                                                                }
                                                                Text("\(item4.tweakName)")
                                                                    .font(.title3)
                                                                    .fontWeight(.semibold)
                                                                    .foregroundColor(Color.mainColor)
                                                            }
                                                        }
                                                        Button("INSTALL") {
                                                            openURL(URL(string: item4.tweakLink)!)
                                                            Haptics.shared.play(.light)
                                                        }
                                                            .buttonStyle(installButton())
                                                    }
                                                }
                                            }
                                        }
                                    }
                                        .frame(height: 205)
                                        .background(LinearGradient(gradient: Gradient(colors: [Color.mint, Color.blue]), startPoint: .leading, endPoint: .trailing))
                                        .clipShape(RoundedRectangle(cornerRadius: 30))
                                        .padding(.horizontal)
                                    HStack {
                                        Text("Other Apps")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            .gradientForeground(colors: [.blue, .purple])
                                            .padding(.horizontal)
                                            .padding(.bottom, 5)
                                        Spacer()
                                    }
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            ForEach(otherResults, id: \.otherID) { item6 in
                                                ZStack {
                                                    Image(systemName: "square.fill")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .foregroundColor(Color.clear)
                                                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                                                        .clipShape(RoundedRectangle(cornerRadius: 18))
                                                        .frame(width: 175, height: 175)
                                                        .padding()
                                                        .shadow(radius: 5)
                                                    VStack {
                                                        NavigationLink(destination:
                                                            HStack {
                                                                VStack {
                                                                    AsyncImage(url: URL(string: item6.otherImage)) { otherImage1 in
                                                                        otherImage1
                                                                            .resizable()
                                                                            .scaledToFit()
                                                                            .cornerRadius(14.3)
                                                                            .frame(width: 65, height: 65, alignment: .center)
                                                                            .shadow(radius: 5)
                                                                    } placeholder: {
                                                                        Image(systemName: "app.fill")
                                                                            .resizable()
                                                                            .scaledToFit()
                                                                            .cornerRadius(14.3)
                                                                            .frame(width: 65, height: 65, alignment: .center)
                                                                            .shadow(radius: 5)
                                                                            .foregroundColor(Color.randomColor)
                                                                    }
                                                                    Button("INSTALL") {
                                                                        openURL(URL(string: item6.otherLink)!)
                                                                        Haptics.shared.play(.light)
                                                                    }
                                                                        .buttonStyle(installButton())
                                                                }
                                                                Text(item6.otherDetail)
                                                            }
                                                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                                                        .navigationBarTitle("\(item6.otherName) (\(item6.otherVersion))", displayMode: .inline)) {
                                                            VStack {
                                                                if reloadImages == 0 {
                                                                    AsyncImage(url: URL(string: item6.otherImage)) { otherImage2 in
                                                                        otherImage2
                                                                            .resizable()
                                                                            .scaledToFit()
                                                                            .cornerRadius(14.3)
                                                                            .frame(width: 65, height: 65, alignment: .center)
                                                                            .shadow(radius: 5)
                                                                    } placeholder: {
                                                                        Image(systemName: "app.fill")
                                                                            .resizable()
                                                                            .scaledToFit()
                                                                            .cornerRadius(14.3)
                                                                            .frame(width: 65, height: 65, alignment: .center)
                                                                            .shadow(radius: 5)
                                                                            .foregroundColor(Color.randomColor)
                                                                    }
                                                                } else {
                                                                    AsyncImage(url: URL(string: item6.otherImage)) { otherImage2 in
                                                                        otherImage2
                                                                            .resizable()
                                                                            .scaledToFit()
                                                                            .cornerRadius(14.3)
                                                                            .frame(width: 65, height: 65, alignment: .center)
                                                                            .shadow(radius: 5)
                                                                    } placeholder: {
                                                                        Image(systemName: "app.fill")
                                                                            .resizable()
                                                                            .scaledToFit()
                                                                            .cornerRadius(14.3)
                                                                            .frame(width: 65, height: 65, alignment: .center)
                                                                            .shadow(radius: 5)
                                                                            .foregroundColor(Color.randomColor)
                                                                    }
                                                                }
                                                                Text("\(item6.otherName)")
                                                                    .font(.title3)
                                                                    .fontWeight(.semibold)
                                                                    .foregroundColor(Color.white)
                                                            }
                                                        }
                                                        Button("INSTALL") {
                                                            openURL(URL(string: item6.otherLink)!)
                                                            Haptics.shared.play(.light)
                                                        }
                                                            .buttonStyle(installButton())
                                                    }
                                                }
                                            }
                                        }
                                    }
                                        .frame(height: 205)
                                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                                        .clipShape(RoundedRectangle(cornerRadius: 30))
                                        .padding(.horizontal)
                                }
                            }
                            .listRowSeparatorTint(.clear)
                            .listRowBackground(Color.clear)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        }
                        .listStyle(.plain)
                        .refreshable {
                            loadData()
                            if UserDefaults.standard.refreshImagesToggle {
                                if reloadImages == 0 {
                                    reloadImages = 1
                                } else {
                                    reloadImages = 0
                                }
                            }
                        }
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {showSettingsView = true}, label: {Image(systemName: "gear")})
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {showAddAppView = true}, label: {Image(systemName: "plus")})
                            }
                        }
                        .navigationTitle("AltApps")
                        .navigationBarBackButtonHidden(true)
                    } else {
                        VStack {
                            List {
                                ForEach(AltAppsRawResults, id: \.UpdateAppID) { item1 in
                                    if item1.AltAppsVersion != "v1.2.0-beta" {
                                        Section("Update Available") {
                                            HStack {
                                                Image("AltAppsIcon")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .cornerRadius(11)
                                                    .frame(width: 50, height: 60, alignment: .center)
                                                    .shadow(radius: 5)
                                                VStack {
                                                    HStack {
                                                        Text("AltApps")
                                                            .font(.title3)
                                                            .fontWeight(.semibold)
                                                            .foregroundColor(Color.white)
                                                        Spacer()
                                                    }
                                                    HStack {
                                                        Text("\(item1.AltAppsVersion)")
                                                            .font(.headline)
                                                            .fontWeight(.semibold)
                                                            .foregroundColor(Color.white)
                                                        Spacer()
                                                    }
                                                }
                                                Spacer()
                                                Button("UPDATE") {
                                                    openURL(URL(string: item1.AltAppsLink)!)
                                                    Haptics.shared.play(.light)
                                                }
                                                    .buttonStyle(installButton())
                                                    .padding(.trailing, 10)
                                            }
                                        }
                                        .foregroundColor(Color.mainColor)
                                    }
                                }
                                .listRowBackground(Color.mainColor)
                                ForEach(appResults, id: \.appID) { item in
                                    NavigationLink(destination:
                                        HStack {
                                            VStack {
                                                AsyncImage(url: URL(string: item.imageLink)) { appImage in
                                                    appImage
                                                        .resizable()
                                                        .scaledToFit()
                                                        .cornerRadius(14.3)
                                                        .frame(width: 65, height: 65, alignment: .center)
                                                        .shadow(radius: 5)
                                                } placeholder: {
                                                    Image(systemName: "app.fill")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .cornerRadius(14.3)
                                                        .frame(width: 65, height: 65, alignment: .center)
                                                        .shadow(radius: 5)
                                                        .foregroundColor(Color.randomColor)
                                                }
                                                Button("INSTALL") {
                                                    openURL(URL(string: item.installLink)!)
                                                    Haptics.shared.play(.light)
                                                }
                                                    .buttonStyle(installButton())
                                            }
                                            Text(item.appDetail)
                                        }
                                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                            .navigationBarTitle(item.appListName, displayMode: .inline)) {
                                        HStack {
                                            if reloadImages == 0 {
                                                AsyncImage(url: URL(string: item.imageLink)) { appImage in
                                                    appImage
                                                        .resizable()
                                                        .scaledToFit()
                                                        .cornerRadius(11)
                                                        .frame(width: 50, height: 60, alignment: .center)
                                                        .shadow(radius: 5)
                                                } placeholder: {
                                                    Image(systemName: "app.fill")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .cornerRadius(11)
                                                        .frame(width: 50, height: 60, alignment: .center)
                                                        .shadow(radius: 5)
                                                        .foregroundColor(Color.randomColor)
                                                }
                                            } else {
                                                AsyncImage(url: URL(string: item.imageLink)) { appImage in
                                                    appImage
                                                        .resizable()
                                                        .scaledToFit()
                                                        .cornerRadius(11)
                                                        .frame(width: 50, height: 60, alignment: .center)
                                                        .shadow(radius: 5)
                                                } placeholder: {
                                                    Image(systemName: "app.fill")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .cornerRadius(11)
                                                        .frame(width: 50, height: 60, alignment: .center)
                                                        .shadow(radius: 5)
                                                        .foregroundColor(Color.randomColor)
                                                }
                                            }
                                            Text("\(item.appListName) \(item.appVersion)")
                                                .font(.title3)
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color.mainColor)
                                            Spacer()
                                            Button("INSTALL") {
                                                openURL(URL(string: item.installLink)!)
                                                Haptics.shared.play(.light)
                                            }
                                                .buttonStyle(installButton())
                                        }
                                    }
                                }
                            }
                            .toolbar {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Button(action: {showSettingsView = true}, label: {Image(systemName: "gear")})
                                }
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button(action: {showAddAppView = true}, label: {Image(systemName: "plus")})
                                }
                            }
                        }
                        .refreshable {
                            loadData()
                            if UserDefaults.standard.refreshImagesToggle {
                                if reloadImages == 0 {
                                    reloadImages = 1
                                } else {
                                    reloadImages = 0
                                }
                            }
                        }
                        .navigationTitle("AltApps")
                        .navigationBarBackButtonHidden(true)
                    }
                }
            }
            if isViewLoading {
                withAnimation {
                    ZStack {
                        Color(UIColor.systemIndigo)
                            .ignoresSafeArea()
                            .opacity(0.95)
                            .blur(radius: 0)
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(3)
                    }
                }
            }
        }
        .sheet(isPresented: $showSettingsView) {
            SettingsView()
        }
        .sheet(isPresented: $showAddAppView) {
            AddCustomAppView()
        }
        .sheet(isPresented: $showWelcomeView) {
            welcomeView().interactiveDismissDisabled()
        }
        .accentColor(Color.mainColor)
        .onAppear(perform: {isViewLoading = true; listLoadData(); AOTDloadData(); featuredJailbreakLoadData(); featuredTweakLoadData(); featuredOtherLoadData(); AltAppsUpdateLoadData()})
    }
    func loadData() {
        listLoadData()
        AOTDloadData()
        featuredJailbreakLoadData()
        featuredTweakLoadData()
        featuredOtherLoadData()
        AltAppsUpdateLoadData()
    }
    func listLoadData() {
        guard let url = URL(string: "https://raw.githubusercontent.com/JiningLiu/AltApps/AltApps_Contents/contentList_1.2.0") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data1, response1, error1 in
            if let data1 = data1 {
                if let decodedResponse1 = try? JSONDecoder().decode(listResponse.self, from: data1) {
                    DispatchQueue.main.async {
                        appResults = decodedResponse1.appResults
                    }
                    return
                }
            }
            print("Fetch failed: \(error1?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    func AOTDloadData() {
        guard let url = URL(string: "https://raw.githubusercontent.com/JiningLiu/AltApps/AltApps_Contents/aotd1.2.0.txt") else {
            print("Invalid URL")
            return
        }
        let request2 = URLRequest(url: url)
        URLSession.shared.dataTask(with: request2) { data3, response3, error3 in
            if let data3 = data3 {
                if let decodedResponse3 = try? JSONDecoder().decode(appOfTheDayResponse.self, from: data3) {
                    DispatchQueue.main.async {
                        aotdResult = decodedResponse3.aotdResult
                    }
                    return
                }
            }
            print("Fetch failed: \(error3?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    func featuredJailbreakLoadData() {
        guard let url = URL(string: "https://raw.githubusercontent.com/JiningLiu/AltApps/AltApps_Contents/featured_jailbreak_1.2.0") else {
            print("Invalid URL")
            return
        }
        let request3 = URLRequest(url: url)
        URLSession.shared.dataTask(with: request3) { data4, response4, error4 in
            if let data4 = data4 {
                if let decodedResponse4 = try? JSONDecoder().decode(jailbreakResponse.self, from: data4) {
                    DispatchQueue.main.async {
                        jailbreakResults = decodedResponse4.jailbreakResults
                    }
                    return
                }
            }
            print("Fetch failed: \(error4?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    func featuredTweakLoadData() {
        guard let url = URL(string: "https://raw.githubusercontent.com/JiningLiu/AltApps/AltApps_Contents/featured_tweak_1.2.0") else {
            print("Invalid URL")
            return
        }
        let request4 = URLRequest(url: url)
        URLSession.shared.dataTask(with: request4) { data5, response5, error5 in
            if let data5 = data5 {
                if let decodedResponse5 = try? JSONDecoder().decode(tweakResponse.self, from: data5) {
                    DispatchQueue.main.async {
                        tweakResults = decodedResponse5.tweakResults
                    }
                    return
                }
            }
            print("Fetch failed: \(error5?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    func featuredOtherLoadData() {
        guard let url = URL(string: "https://raw.githubusercontent.com/JiningLiu/AltApps/AltApps_Contents/featured_other_1.2.0") else {
            print("Invalid URL")
            return
        }
        let request6 = URLRequest(url: url)
        URLSession.shared.dataTask(with: request6) { data7, response7, error7 in
            if let data7 = data7 {
                if let decodedResponse7 = try? JSONDecoder().decode(otherResponse.self, from: data7) {
                    DispatchQueue.main.async {
                        otherResults = decodedResponse7.otherResults
                    }
                    return
                }
            }
            print("Fetch failed: \(error7?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    func AltAppsUpdateLoadData() {
        guard let url = URL(string: "https://raw.githubusercontent.com/JiningLiu/AltApps/AltApps_Contents/1.2.0beta1update.txt") else {
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
        isViewLoading = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ContentView().preferredColorScheme($0)
        }
    }
}
