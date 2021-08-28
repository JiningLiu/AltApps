//
//  refresh.swift
//  refresh
//
//  Created by JingJing on 8/28/21.
//

import SwiftUI

struct refresh<Content: View>: View {
    var content: Content
    var onRefresh: ()->()
    init(title: String, tintColor: Color, @ViewBuilder content: @escaping ()->Content, onRefresh: @escaping ()->()) {
        self.content = content()
        self.onRefresh = onRefresh
    }
    var body: some View {
        List {
            content
                .listRowSeparatorTint(.clear)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
        .refreshable {
            onRefresh()
        }
    }
}

struct refresh_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
