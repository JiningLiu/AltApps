//
//  ContentView.swift
//  AltApps
//
//  Created by JingJing on 7/25/21.
//

import SwiftUI

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

extension String {
    func loadImage() -> UIImage {
        do {
            guard let imageURL = URL(string: self)
        else {
            return UIImage()
        }
            let imageData: Data = try Data(contentsOf: imageURL)
            return UIImage(data: imageData) ?? UIImage()
        } catch {
            //
        }
        return UIImage()
    }
}

struct ContentView: View {
    @State var appResults = [listResult]()
    @State var showWelcomeView = UserDefaults.standard.showWelcomeScreen
    var body: some View {
        NavigationView {
            VStack {
                if #available(iOS 14.0, *) {
                    List(appResults, id: \.appID) { item1 in
                        NavigationLink(destination:
                            HStack {
                                VStack {
                                    Image(uiImage: item1.imageLink.loadImage())
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(14.3)
                                        .frame(width: 65, height: 65, alignment: .center)
                                        .shadow(radius: 5)
                                    Button("INSTALL") {
                                        UIApplication.shared.open(URL(string: item1.installLink)!)
                                        Haptics.shared.play(.light)
                                    }
                                        .buttonStyle(installButton())
                                }
                                Text(item1.appDetail)
                            }
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            .navigationBarTitle(Text(item1.appListName), displayMode: .inline)
                            , label: {
                            HStack {
                                Image(uiImage: item1.imageLink.loadImage())
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(11)
                                    .frame(width: 50, height: 50, alignment: .center)
                                    .shadow(radius: 5)
                                Text("\(item1.appListName) \(item1.appVersion)")
                                    .font(.system(size: 18))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.mainColor)
                                Spacer()
                                Button("INSTALL") {
                                    UIApplication.shared.open(URL(string: item1.installLink)!)
                                    Haptics.shared.play(.light)
                                }
                                    .buttonStyle(installButton())
                            }
                        })
                    }
                    .navigationBarTitle("AltApps")
                } else {
                    List(appResults, id: \.appID) { item1 in
                        NavigationLink(destination:
                            HStack {
                                VStack {
                                    Image(uiImage: item1.imageLink.loadImage())
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(14.3)
                                        .frame(width: 65, height: 65, alignment: .center)
                                        .shadow(radius: 5)
                                    Button("INSTALL") {
                                        UIApplication.shared.open(URL(string: item1.installLink)!)
                                        Haptics.shared.play(.light)
                                    }
                                        .buttonStyle(installButton())
                                }
                                Text(item1.appDetail)
                            }
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            .navigationBarTitle(Text(item1.appListName), displayMode: .inline)
                            , label: {
                            HStack {
                                Image(uiImage: item1.imageLink.loadImage())
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(11)
                                    .frame(width: 50, height: 60, alignment: .center)
                                    .shadow(radius: 5)
                                Text("\(item1.appListName) \(item1.appVersion)")
                                    .font(.system(size: 18))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.mainColor)
                                Spacer()
                                Button("INSTALL") {
                                    UIApplication.shared.open(URL(string: item1.installLink)!)
                                    Haptics.shared.play(.light)
                                }
                                    .buttonStyle(installButton())
                            }
                        })
                    }
                    .listStyle(GroupedListStyle())
                    .environment(\.horizontalSizeClass, .regular)
                    .navigationBarTitle("AltApps")
                }
            }
        }
        .onAppear(perform: listLoadData)
        .sheet(isPresented: $showWelcomeView) {
            welcomeView()
        }
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
                        self.appResults = decodedResponse1.appResults
                    }
                    return
                }
            }
            print("Fetch failed: \(error1?.localizedDescription ?? "Unknown error")")
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
