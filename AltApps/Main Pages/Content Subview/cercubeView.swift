//
//  cercubeView.swift
//  AltApps
//
//  Created by JingJing on 7/27/21.
//

import SwiftUI

struct cercubeView: View {
    var body: some View {
            Link(
                destination: URL(string: "altstore://install?url=https://rebrand.ly/altapps_cercube_app-download")!,
                label: {
                    VStack {
                        Image("Cercube")
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

struct cercubeView_Previews: PreviewProvider {
    static var previews: some View {
        cercubeView()
    }
}
