//
//  customButtonLarge.swift
//  customButtonLarge
//
//  Created by JingJing on 8/3/21.
//

import SwiftUI

struct ButtonModifier2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.headline)
            .padding()
            .frame(minWidth: 0, maxWidth: 235, alignment: .center)
            .background(Color.mainColor)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .shadow(radius: 10)
    }
}

extension View {
    func customButtonLarge() -> ModifiedContent<Self, ButtonModifier2> {
        return modifier(ButtonModifier2())
    }
}
