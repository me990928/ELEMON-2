//
//  SelfManagementView.swift
//  U22_Prot
//
//  Created by 広瀬友哉 on 2023/04/21.
//

import SwiftUI

struct SelfManagementBarView: View {
    var body: some View {
        VStack{
            TabView {
                Page1View()
                    .tabItem {
                        Image(systemName: "figure.walk")
                        Text("")
                    }
                GoalView()
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("")
                    }
                ComuView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("")
                    }
                settings()
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("")
                    }
            }
        }
    }
}

struct SelfManagementView_Previews: PreviewProvider {
    static var previews: some View {
        SelfManagementBarView().environmentObject(FirestoreModel()).environmentObject(FireAuthModel()).environmentObject(HealthSleep()).environmentObject(TabModel()).environmentObject(ColorThema())
    }
}
