//
//  welcomeView.swift.swift
//  welcomeView.swift
//
//  Created by JingJing on 9/12/21.
//  Copyright © 2021 JingJing. All rights reserved.
//

import SwiftUI
import UIKit

extension UserDefaults {
    var showWelcomeScreen: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "showWelcomeScreen") as? Bool) ?? true
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "showWelcomeScreen")
        }
    }
}

struct welcomeView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Spacer()
                    HStack {
                        Image("AltAppsIcon")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16.5)
                            .frame(width: 75, height: 75, alignment: .center)
                            .shadow(radius: 5)
                        Spacer()
                        VStack {
                            Text("Welcome to")
                                .customTitleText()
                            Text("AltApps")
                                .customTitleText()
                                .foregroundColor(.mainColor)
                        }
                    }
                        .padding(.horizontal)
                    VStack(alignment: .leading) {
                        InformationDetailView(title: "Apps", subTitle: "AltApps provides tweaked, original, and jailbreaking apps for AltStore users, for free.", imageName: "square.stack")
                        InformationDetailView(title: "Updates", subTitle: "With constant updates, AltApps will give you the best user experience without revokes.", imageName: "square.and.arrow.up")
                        InformationDetailView(title: "Simple", subTitle: "AltApps is easy to use, no ads, just like the App Store, no need to worry.", imageName: "checkmark.square")
                    }
                Spacer()
                Button(action: {presentationMode.wrappedValue.dismiss()}, label: {Text("Continue").customButtonSmall()})
            }
                .padding(.horizontal)
                .navigationBarTitle("Back")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
        .onAppear(perform: {UserDefaults.standard.showWelcomeScreen = false})
    }
}

        
struct welcomeView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            welcomeView().preferredColorScheme($0)
        }
    }
}
