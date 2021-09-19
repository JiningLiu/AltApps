//
//  updateView.swift
//  updateView
//
//  Created by JingJing on 9/19/21.
//

import SwiftUI

struct updateView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Spacer()
                    VStack {
                        Image("AltAppsIcon")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16.5)
                            .frame(width: 75, height: 75, alignment: .center)
                            .shadow(radius: 5)
                            .padding(.bottom, 10)
                        Text("What's New in")
                            .customTitleText()
                        Text("AltApps")
                            .customTitleText()
                            .foregroundColor(.mainColor)
                    }
                    VStack(alignment: .leading) {
                        InformationDetailView(title: "Refresh", subTitle: "Tap on the refresh button at the bottom of the page to refresh.", imageName: "arrow.clockwise")
                        InformationDetailView(title: "App List", subTitle: "A full app list is now available for featured view, located at the bottom of the page.", imageName: "list.bullet")
                    }
                Spacer()
                Button(action: {UserDefaults.standard.showUpdate = false; presentationMode.wrappedValue.dismiss()}, label: {Text("Continue").customButtonSmall()})
            }
                .padding(.horizontal)
                .navigationBarHidden(true)
        }
        .interactiveDismissDisabled()
    }
}

struct updateView_Previews: PreviewProvider {
    static var previews: some View {
        updateView()
    }
}
