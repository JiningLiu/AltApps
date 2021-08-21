//
//  StartView.swift
//  StartView
//
//  Created by JingJing on 8/3/21.
//

import SwiftUI

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
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

struct StartView: View {
    var body: some View {
        if UserDefaults.standard.welcomeScreenShown {
            ContentView()
                .navigationBarTitle(" ")
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
        } else {
            welcomeView()
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
