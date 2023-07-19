//
//  GroupTopView.swift
//  Comu
//
//  Created by 広瀬友哉 on 2023/05/25.
//

import SwiftUI

struct GroupTopView: View {
    @AppStorage ("groupSearch") var groupSearch: Int = 1
    @AppStorage ("groupBtn") var groupBtn: Int = 1
    var body: some View {
        VStack{
            if(groupSearch == 0){
                GroupCreateView().padding()
            }
            if(groupSearch == 1){
                GroupSearchView().padding()
            }
            if(groupSearch == 2){
                GroupChatView(store: FirestoreModel())
            }
            Spacer()
            if(groupBtn == 1){
                HStack{
                    Spacer()
                    Button("グループ作成"){
                        groupSearch = 0
                    }.buttonStyle(.bordered)
                    Spacer()
                    Button("グループ探す"){
                        groupSearch = 1
                    }.buttonStyle(.bordered)
                    Spacer()
                }.padding()
            }
        }
    }
}

struct GroupTopView_Previews: PreviewProvider {
    static var previews: some View {
        GroupTopView()
    }
}
