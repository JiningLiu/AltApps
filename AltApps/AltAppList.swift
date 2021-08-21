//
//  AltAppList.swift
//  AltApps
//
//  Created by JingJing on 7/26/21.
//

import SwiftUI

struct AltAppList: Identifiable {
    var id = UUID()
    var AppName: String
    var AppIcon: String {return AppName}
}

#if DEBUG
let AppList = [
    AltAppList(AppName: "App1"),
    AltAppList(AppName: "App2"),
    AltAppList(AppName: "App3"),
    AltAppList(AppName: "App4"),
    AltAppList(AppName: "App5"),
]
#endif
