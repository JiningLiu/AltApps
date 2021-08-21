//
//  customButtonLarge.swift
//  customButtonLarge
//
//  Created by JingJing on 7/30/21.
//

import SwiftUI

struct ButtonModifier2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.headline)
            .padding()
            .frame(minWidth: 0, maxWidth: 235, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.mainColor))
            .shadow(radius: 10)
            .padding(.bottom)
    }
}

extension View {
    func customButtonLarge() -> ModifiedContent<Self, ButtonModifier2> {
        return modifier(ButtonModifier2())
    }
}
