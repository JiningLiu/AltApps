//
//  customButtonSmall.swift
//  customButtonSmall
//
//  Created by JingJing on 7/30/21.
//

import SwiftUI

struct ButtonModifier1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.headline)
            .padding()
            .frame(minWidth: 0, maxWidth: 150, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
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

extension Text {
    func customTitleText() -> Text {
        self
            .fontWeight(.black)
            .font(.system(size: 36))
    }
}

extension Color {
    static var mainColor = Color(UIColor.systemIndigo)
}
