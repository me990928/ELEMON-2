//
//  Test-A.swift
//  Comu
//
//  Created by 広瀬友哉 on 2023/05/25.
//

import SwiftUI

struct ComuTopView: View {
    
    @AppStorage ("groupSearch") var groupSearch: Int = 1
    
    @State var selectedValue: Int = 0
    
    var body: some View {
        GeometryReader{ geoVal in
            VStack{
                Picker("", selection: $selectedValue) {
                    Text("グループ").tag(0)
                    Text("詳細").tag(1)
                }.pickerStyle(.segmented)
                    .padding()
                
                if(selectedValue == 0){
                    GroupTopView()
                }
                if(selectedValue == 1 && groupSearch == 2){
                    MokuhyoTopView().padding(.top)
                }
                if(selectedValue == 1 && groupSearch != 2){
                    Spacer()
                    Text("グループ未参加")
                    Spacer()
                }
            }
        }
    }
}

struct TestA_Previews: PreviewProvider {
    static var previews: some View {
        ComuTopView()
    }
}
