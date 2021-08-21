//
//  welcomeView.swift
//  AltApps
//
//  Created by JingJing on 7/28/21.
//

import SwiftUI

struct welcomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center) {
                    Spacer()
                        VStack {
                            Image("AltAppsBanner")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                .shadow(radius: 10)
                                .frame(width: 225, height: 225, alignment: .center)
                            Text("Welcome to")
                                .customTitleText()
                            Text("AltApps")
                                .customTitleText()
                                .foregroundColor(.mainColor)
                        }
                        VStack(alignment: .leading) {
                                InformationDetailView(title: "Apps", subTitle: "AltApps provides tweaked, original, and jailbreaking apps for AltStore users, for free.", imageName: "square.stack")
                                InformationDetailView(title: "Updates", subTitle: "With constant updates, AltApps will give you the best user experience without revokes.", imageName: "square.and.arrow.up")
                                InformationDetailView(title: "Simple", subTitle: "AltApps is easy to use, no ads, just like the App Store, no need to worry.", imageName: "checkmark.square")
                                }
                            Spacer(minLength: 28)
                            NavigationLink(
                                destination:
                                    ContentView()
                                    .navigationBarTitle(" ")
                                    .navigationBarHidden(true)
                                    .navigationBarBackButtonHidden(true),
                                label: {
                                    Text("Continue")
                                        .customButtonSmall()
                                })
                        }
                        .padding(.horizontal)
                    }
            .navigationBarTitle(" ")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
                }
                .onAppear(perform: {
                    UserDefaults.standard.welcomeScreenShown = true
        })
                .navigationViewStyle(.stack)
    }
}

struct welcomeView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            welcomeView().preferredColorScheme($0)
        }
    }
}
