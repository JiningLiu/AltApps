//
//  creditView.swift
//  AltApps
//
//  Created by JingJing on 7/28/21.
//

import SwiftUI

struct creditView: View {
    var body: some View {
        VStack {
            HStack {
                Image("unc0ver")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(11)
                    .frame(width: 50, height: 50, alignment: .center)
                VStack {
                    Text("Made by the unc0ver team")
                    Link("More info at unc0ver.dev", destination: URL(string: "https://unc0ver.dev")!).foregroundColor(.mainColor)
                }
            }
            Text(" ")
                .font(.caption2)
            HStack {
                Image("Cercube")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(11)
                    .frame(width: 50, height: 50, alignment: .center)
                VStack {
                    Text("Made by Majd Alfhaily")
                    Link("More info at alfhaily.me", destination: URL(string: "https://alfhaily.me")!).foregroundColor(.mainColor)
                }
            }
            Text(" ")
                .font(.caption2)
            HStack {
                Image("AltApps")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(11)
                    .frame(width: 50, height: 50, alignment: .center)
                Text("Made by Jining Liu")
            }
            Text(" ")
                .font(.largeTitle)
            Text(" ")
                .font(.largeTitle)
        }
    }
}
struct creditView_Previews: PreviewProvider {
    static var previews: some View {
        creditView()
    }
}
