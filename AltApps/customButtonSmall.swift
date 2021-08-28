//
//  customButtonSmall.swift
//  customButtonSmall
//
//  Created by JingJing on 8/26/21.
//

import SwiftUI

struct ButtonModifier1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.headline)
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.mainColor))
            .shadow(radius: 10)
            .padding(.bottom)
    }
}

extension View {
    func customButtonSmall() -> ModifiedContent<Self, ButtonModifier1> {
        return modifier(ButtonModifier1())
    }
}
