//
//  customButton2.swift
//  customButton2
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
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.mainColor))
            .shadow(radius: 10)
            .padding(.bottom)
    }
}

extension View {
    func customButton2() -> ModifiedContent<Self, ButtonModifier> {
        return modifier(ButtonModifier())
    }
}
