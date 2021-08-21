//
//  NewsView.swift
//  NewsView
//
//  Created by JingJing on 8/7/21.
//

import SwiftUI

struct newsResponse: Codable {
    var newsResults: [newsResult]
}

struct newsResult: Codable {
    var newsID: Int
    var newsTitle: String
    var newsLink: String
    var newsImage: String
}

struct NewsView: View {
    @State var newsResults = [newsResult]()
    var body: some View {
        NavigationView {
            VStack {
                List(newsResults, id: \.newsID) { item2 in
                    Text("1")
                    Text("2")
                    Text("3")
                }
            }
            .navigationTitle("News")
        }
    }
    func newsLoadData() {
        guard let url = URL(string: "https://rebrand.ly/altapps_contentlist") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data3, response3, error3 in
            if let data3 = data3 {
                if let decodedResponse3 = try? JSONDecoder().decode(newsResponse.self, from: data3) {
                    DispatchQueue.main.async {
                        newsResults = decodedResponse3.newsResults
                    }
                    return
                }
            }
            print("Fetch failed: \(error3?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
