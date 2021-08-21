//
//  MainView.swift
//  AltApps
//
//  Created by JingJing on 7/26/21.
//

import SwiftUI

struct MainView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        NavigationView {
            TabView {
                ContentView()
                    .tabItem {
                        VStack {
                            Image(systemName: "house").renderingMode(.template)
                            Text("Home")
                        }
                    }
                    .navigationTitle(" ")
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                UpdateView()
                    .tabItem {
                        VStack {
                            Image(systemName: "square.and.arrow.up").renderingMode(.template)
                            Text("Updates")
                        }
                    }
                    .navigationTitle(" ")
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                AboutView()
                    .tabItem {
                        VStack {
                            Image(systemName: "info.circle").renderingMode(.template)
                            Text("About")
                        }
                    }
                    .navigationTitle(" ")
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
            }
            .accentColor(.mainColor)
            .navigationTitle(" ")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            MainView().preferredColorScheme($0)
        }
    }
}
