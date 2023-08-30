//
//  SelfManagementView.swift
//  U22_Prot
//
//  Created by 広瀬友哉 on 2023/04/21.
//

import SwiftUI

class ViewState: ObservableObject{
    @Published var selectedTabNum: Int = 0
}

struct SelfManagementBarView: View {
    
    @EnvironmentObject var viewNum: ViewState
    
    var body: some View {
        VStack{
            TabView(selection: $viewNum.selectedTabNum) {
                Page1View()
                    .tabItem {
                        Image(systemName: "figure.walk")
                        Text("")
                    }.tag(0)
                GoalView()
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("")
                    }.tag(1)
                TopPage()
                    .tabItem {
                        Image(systemName: "person")
                        Text("")
                    }.tag(2)
                settings()
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("")
                    }.tag(3)
            }
        }
    }
}

struct SelfManagementView_Previews: PreviewProvider {
    static var previews: some View {
        SelfManagementBarView().environmentObject(FirestoreModel()).environmentObject(FireAuthModel()).environmentObject(HealthSleep()).environmentObject(TabModel()).environmentObject(ColorThema()).environmentObject(ViewState())
    }
}
