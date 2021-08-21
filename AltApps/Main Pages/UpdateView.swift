//
//  UpdateView.swift
//  AltApps
//
//  Created by JingJing on 7/26/21.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var appId: Int
    var appName: String
    var updateDetail: String
    var updateLink: String
    var imageLink1: String
}

struct UpdateView: View {
    @State var results = [Result]()
    var body: some View {
        NavigationView {
            VStack {
                List(results, id: \.appId) { item in
                    let updateListText = item.appName + " " + item.updateDetail
                    HStack {
                        Image(uiImage: item.imageLink1.loadImage())
                            .resizable()
                            .cornerRadius(11)
                            .frame(width: 50, height: 50, alignment: .center)
                            .shadow(radius: 5)
                        NavigationLink(
                            destination:
                                Link(
                                    destination: URL(string: item.updateLink)!,
                                    label: {
                                        VStack {
                                            Image(uiImage: item.imageLink1.loadImage())
                                                .resizable()
                                                .cornerRadius(22)
                                                .frame(width: 100, height: 100)
                                                .shadow(radius: 10)
                                                .padding()
                                            Text("Install " + updateListText + " with AltStore")
                                                .padding(.bottom)
                                        }
                                        .customButtonLarge()
                                        .padding()
                                        .navigationBarTitle(item.appName, displayMode: .inline)
                                    }),
                            label: {
                                Text(updateListText)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.mainColor)
                            })
                    }
                }
                .navigationTitle("Updates")
            }
        }
        .onAppear(perform: loadData)
    }
    func loadData() {
        guard let url = URL(string: "https://rebrand.ly/altapps_updateviewlist") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        self.results = decodedResponse.results
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct UpdateView_Previews : PreviewProvider {
    static var previews: some View {
        UpdateView()
    }
}
