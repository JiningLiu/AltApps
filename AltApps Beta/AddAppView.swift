//
//  AddAppView.swift
//  AddAppView
//
//  Created by JingJing on 8/5/21.
//

import SwiftUI

struct AddAppView: View {
    var body: some View {
        VStack {
            List {
                NavigationLink(destination: AddCustomAppView()) {
                    HStack {
                        Image(systemName: "plus.app")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 40)
                            .foregroundColor(Color.mainColor)
                        Text("Install other apps")
                            .font(.title3)
                            .foregroundColor(Color.mainColor)
                    }
                }
                NavigationLink(destination: WebView(request: URLRequest(url: URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSetS7tj3Eju3JCk1AltO3eBvyd4-A5D-ljfUrIZoi5wQTp-sQ/viewform?usp=sf_link")!)).navigationBarTitle("Recommend New Apps", displayMode: .inline)) {
                    HStack {
                        Image(systemName: "square.and.arrow.up.on.square")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 40)
                            .foregroundColor(Color.mainColor)
                        Text("Recommend new apps")
                            .font(.title3)
                            .foregroundColor(Color.mainColor)
                    }
                }
            }
        }
        .navigationBarTitle("Add Apps")
    }
}

struct AddAppView_Previews: PreviewProvider {
    static var previews: some View {
        AddAppView()
    }
}
