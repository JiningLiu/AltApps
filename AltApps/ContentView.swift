//
//  ContentView.swift
//  AltApps
//
//  Created by JingJing on 7/25/21.
//

import SwiftUI

struct listResponse: Codable {
    var appResults: [listResult]
}

struct listResult: Codable {
    var appID: Int
    var appListName: String
    var appVersion: String
    var installLink: String
    var imageLink: String
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
    var body: some View {
        NavigationView {
            VStack {
                List(appResults, id: \.appID) { item1 in
                    let appListText = item1.appListName + " " + item1.appVersion
                    HStack {
                        Image(uiImage: item1.imageLink.loadImage())
                            .resizable()
                            .cornerRadius(11)
                            .frame(width: 50, height: 50, alignment: .center)
                            .shadow(radius: 5)
                        NavigationLink(
                            destination:
                                Link(
                                    destination:
                                        URL(string: item1.installLink)!,
                                    label: {
                                        VStack {
                                            Image(uiImage: item1.imageLink.loadImage())
                                                .resizable()
                                                .cornerRadius(22)
                                                .frame(width: 100, height: 100, alignment: .top)
                                                .shadow(radius: 10)
                                                .padding()
                                            Text("Install " + appListText + " with AltStore")
                                                .padding(.bottom)
                                        }
                                        .customButtonLarge()
                                        .padding(.bottom, 50)
                                        .navigationBarTitle(item1.appListName, displayMode: .inline)
                                    }),
                            label: {
                                Text(appListText)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.mainColor)
                            })
                    }
                }
                .navigationTitle("AltApps")
            }
        }
        .onAppear(perform: listLoadData)
    }
    func listLoadData() {
        guard let url = URL(string: "https://rebrand.ly/altapps_contentlist") else {
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
