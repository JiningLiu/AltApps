//
//  UpdateView.swift
//  UpdateView
//
//  Created by JingJing on 8/6/21.
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

struct UpdateView: View {
    @State var AltAppsRawResults = [AltAppsUpdateResult]()
    var body: some View {
                List(AltAppsRawResults, id: \.UpdateAppID) { item1 in
                    if item1.AltAppsVersion == "v1.2.0-beta" {
                        Text("You are all up to date! (\(item1.AltAppsVersion))")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.mainColor)
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                    } else {
                        NavigationLink(
                            destination:
                                Link(
                                    destination:
                                        URL(string: item1.AltAppsLink)!,
                                    label: {
                                        VStack {
                                            Image("AltAppsIcon")
                                                .resizable()
                                                .cornerRadius(22)
                                                .frame(width: 100, height: 100, alignment: .top)
                                                .shadow(radius: 10)
                                                .padding()
                                            Text("Update AltApps with AltStore (\(item1.AltAppsVersion))")
                                                .padding(.bottom)
                                        }
                                        .customButtonLarge()
                                        .navigationBarTitle("AltApps Update", displayMode: .inline)
                                    }),
                                label: {
                                    Text("AltApps \(item1.AltAppsVersion)")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.mainColor)
                                        .padding(.top, 10)
                                        .padding(.bottom, 10)
                            })
                    }
                }
        .onAppear(perform: AltAppsUpdateLoadData)
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

struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateView()
    }
}
