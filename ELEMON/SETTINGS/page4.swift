//
//  page4.swift
//  U22_Prot
//
//  Created by Yuya Hirose on 2023/05/31.
//

import SwiftUI

struct page4: View {
    var body: some View {
        TabView {
            settings()
                .toolbarBackground(.visible, for: .navigationBar, .tabBar)
                .tabItem {
                Image(systemName: "gearshape")
                Text("設定")
            }
        }
    }
}

struct page4_Previews: PreviewProvider {
    static var previews: some View {
        page4()
    }
}
