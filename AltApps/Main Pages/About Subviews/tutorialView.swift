//
//  tutorialView.swift
//  AltApps
//
//  Created by JingJing on 7/28/21.
//

import SwiftUI

struct tutorialView: View {
    var body: some View {
        VStack {
            Text("Hi there!")
                .font(.title)
            Text("Welcome to...")
                .font(.title3)
            Image("AltAppsBanner")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(100)
            Text(" ")
                .font(.caption2)
            NavigationLink(
                destination: tutorialPage1(),
                label: {
                    Text("Next >")
                        .font(.title3)
                        .foregroundColor(Color.blue)
                })
        }
        .navigationBarTitle("Tutorial", displayMode: .inline)
    }
}

struct tutorialView_Previews: PreviewProvider {
    static var previews: some View {
        tutorialView()
    }
}
