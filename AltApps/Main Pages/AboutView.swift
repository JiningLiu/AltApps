//
//  AboutView.swift
//  AltApps
//
//  Created by JingJing on 7/27/21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: creditView(),
                    label: {
                        Text("Credits")
                })
                NavigationLink(
                    destination: systemInfoView(),
                    label: {
                        Text("System Info")
                })
                NavigationLink(
                    destination: VersionView(),
                    label: {
                        Text("Version")
                })
            }
            .navigationBarTitle("About")
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
