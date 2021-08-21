//
//  systemInfoView.swift
//  AltApps
//
//  Created by JingJing on 7/28/21.
//

import SwiftUI

struct systemInfoView: View {
    var body: some View {
        VStack{
            Text(UIDevice.current.model)
            Text(UIDevice.current.systemName + " " + UIDevice.current.systemVersion)
            Text(UIDevice.current.description)
        }
    }
}

struct systemInfoView_Previews: PreviewProvider {
    static var previews: some View {
        systemInfoView()
    }
}
