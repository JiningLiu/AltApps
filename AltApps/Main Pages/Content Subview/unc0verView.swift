//
//  unc0verView.swift
//  AltApps
//
//  Created by JingJing on 7/27/21.
//

import SwiftUI

struct unc0verView: View {
    var body: some View {
            Link(
                destination: URL(string: "altstore://install?url=https://rebrand.ly/altapps_unc0ver_app-download")!,
                label: {
                    VStack {
                        Image("unc0ver")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(22)
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .top)
                            .shadow(radius: 10)
                            .padding()
                        Text("Install with AltStore")
                            .padding(.bottom)
                    }
                    .customButton().padding()
                })
        .navigationBarTitle("unc0ver", displayMode: .inline)
    }
}

struct unc0verView_Previews: PreviewProvider {
    static var previews: some View {
        unc0verView()
    }
}
