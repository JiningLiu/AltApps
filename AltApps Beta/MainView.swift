//
//  MainView.swift
//  MainView
//
//  Created by JingJing on 8/6/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            TabView {
                ContentView()
                    .navigationBarTitle(" ")
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                    .tabItem {
                        VStack {
                            Image(systemName: "square.dashed.inset.filled")
                            Text("Apps")
                        }
                    }
                NewsView()
                    .navigationBarTitle(" ")
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                    .tabItem {
                        VStack {
                            Image(systemName: "newspaper")
                            Text("News")
                        }
                    }
            }
            .navigationBarTitle(" ")
            .navigationBarHidden(true)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
