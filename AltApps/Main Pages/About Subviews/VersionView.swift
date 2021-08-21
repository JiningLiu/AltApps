//
//  VersionView.swift
//  AltApps
//
//  Created by JingJing on 7/27/21.
//

import SwiftUI

struct VersionView: View {
    var body: some View {
        VStack {
            Text("©2021 AltApps, all rights reserved")
                .font(.footnote)
            Text("This app is in no way associated with any companies/groups")
                .font(.footnote)
            Text("Version alpha 0.0.1")
                .font(.footnote)
        }
    }
}

struct VersionView_Previews: PreviewProvider {
    static var previews: some View {
        VersionView()
    }
}
