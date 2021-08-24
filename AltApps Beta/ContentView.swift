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

struct devAppResponse: Codable {
    var devAppResults: [devAppResult]
}

struct devAppResult: Codable {
    var devAppID: Int
    var devAppName: String
    var devAppVersion: String
    var devAppLink: String
    var devAppImage: String
    var devAppDetail: String
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
    @State var devAppResults = [devAppResult]()
    @State var showWelcomeView = UserDefaults.standard.showWelcomeScreen
    @State var reloadImages = 0
    @State var showAddAppView = false
    @Environment(\.openURL) var openURL
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    if UserDefaults.standard.showFeaturedView == 0 {
                        VStack {
                            ScrollView {
                                HStack {
                                    Text("App of The Week")
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.mainColor)
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
                                        .foregroundColor(Color.mainColor)
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
                                                    .foregroundColor(Color.mint)
                                                    .clipShape(RoundedRectangle(cornerRadius: 18))
                                                    .frame(width: 175, height: 175)
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
                                                .padding(.horizontal)
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
                                        .foregroundColor(Color.mainColor)
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
                                                    .foregroundColor(Color.cyan)
                                                    .clipShape(RoundedRectangle(cornerRadius: 18))
                                                    .frame(width: 175, height: 175)
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
                                            .padding(.horizontal)
                                        }
                                    }
                                }
                                    .frame(height: 205)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.mint, Color.blue]), startPoint: .leading, endPoint: .trailing))
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                                    .padding(.horizontal)
                                Section(header: Text("From AltApps Devs").foregroundColor(Color.mainColor)) {
                                    ForEach(devAppResults, id: \.devAppID) { item5 in
                                        NavigationLink(destination:
                                            HStack {
                                                VStack {
                                                    AsyncImage(url: URL(string: item5.devAppImage)) { devAppImage1 in
                                                        devAppImage1
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
                                                        openURL(URL(string: item5.devAppLink)!)
                                                        Haptics.shared.play(.light)
                                                    }
                                                        .buttonStyle(installButton())
                                                }
                                                Text(item5.devAppDetail)
                                            }
                                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                                .navigationBarTitle(item5.devAppName, displayMode: .inline)) {
                                            HStack {
                                                if reloadImages == 0 {
                                                    AsyncImage(url: URL(string: item5.devAppImage)) { devAppImage2 in
                                                        devAppImage2
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
                                                    AsyncImage(url: URL(string: item5.devAppImage)) { devAppImage2 in
                                                        devAppImage2
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
                                                Text("\(item5.devAppName) \(item5.devAppVersion)")
                                                    .font(.title3)
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(Color.white)
                                                Spacer()
                                                Button("INSTALL") {
                                                    openURL(URL(string: item5.devAppLink)!)
                                                    Haptics.shared.play(.light)
                                                }
                                                    .buttonStyle(installButton())
                                            }
                                        }
                                    }
                                }
                                .listRowBackground(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                            }
                        }
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                NavigationLink(
                                    destination: SettingsView(),
                                    label: {
                                        Image(systemName: "gear")
                                            .foregroundColor(Color.mainColor)
                                    }
                                )
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {showAddAppView = true}, label: {Image(systemName: "plus")})
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
                    } else {
                        VStack {
                            List(appResults, id: \.appID) { item in
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
                            .toolbar {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    NavigationLink(
                                        destination: SettingsView(),
                                        label: {
                                            Image(systemName: "gear")
                                                .foregroundColor(Color.mainColor)
                                        }
                                    )
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
        .sheet(isPresented: $showAddAppView) {
            AddCustomAppView()
        }
        .sheet(isPresented: $showWelcomeView) {
            welcomeView().interactiveDismissDisabled()
        }
        .accentColor(Color.mainColor)
        .onAppear(perform: {isViewLoading = true; listLoadData(); AOTDloadData(); featuredJailbreakLoadData(); featuredTweakLoadData(); featuredDevAppLoadData()})
    }
    func loadData() {
        listLoadData()
        AOTDloadData()
        featuredJailbreakLoadData()
        featuredTweakLoadData()
        featuredDevAppLoadData()
    }
    func listLoadData() {
        guard let url = URL(string: "https://rebrand.ly/altapps_contentlist_1-2-0") else {
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
        guard let url = URL(string: "https://rebrand.ly/altapps_aotd_1-2-0") else {
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
        guard let url = URL(string: "https://rebrand.ly/altapps_featured_jailbreak_1-2-0") else {
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
        guard let url = URL(string: "https://rebrand.ly/altapps_featured_tweak_1-2-0") else {
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
    func featuredDevAppLoadData() {
        guard let url = URL(string: "https://rebrand.ly/altapps_featured_devapp_1-2-0") else {
            print("Invalid URL")
            return
        }
        let request5 = URLRequest(url: url)
        URLSession.shared.dataTask(with: request5) { data6, response6, error6 in
            if let data6 = data6 {
                if let decodedResponse6 = try? JSONDecoder().decode(devAppResponse.self, from: data6) {
                    DispatchQueue.main.async {
                        devAppResults = decodedResponse6.devAppResults
                        isViewLoading = false
                    }
                    return
                }
            }
            print("Fetch failed: \(error6?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ContentView().preferredColorScheme($0)
        }
    }
}
