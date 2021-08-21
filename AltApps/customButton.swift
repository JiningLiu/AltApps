//
//  customButton.swift
//  AltApps
//
//  Created by JingJing on 7/28/21.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.headline)
            .padding()
            .frame(minWidth: 0, maxWidth: 210, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.mainColor))
            .shadow(radius: 10)
            .padding(.bottom)
    }
}

extension View {
    func customButton() -> ModifiedContent<Self, ButtonModifier> {
        return modifier(ButtonModifier())
    }
}


