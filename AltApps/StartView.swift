//
//  StartView.swift
//  AltApps
//
//  Created by JingJing on 7/28/21.
//

import SwiftUI

extension UserDefaults {
    var welcomeScreenShown: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "welcomeScreenShown") as? Bool) ?? false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "welcomeScreenShown")
        }
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

struct StartView: View {
    var body: some View {
        if UserDefaults.standard.welcomeScreenShown {
            ContentView()
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
