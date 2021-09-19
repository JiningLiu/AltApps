//
//  installButton.swift
//  AltApps
//
//  Created by JingJing on 8/8/21.
//

import SwiftUI

struct installButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 12, weight: .semibold))
            .padding(EdgeInsets(top: 7.5, leading: 10, bottom: 7.5, trailing: 10))
            .background(Color.mainColor)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .shadow(radius: 2.5)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
