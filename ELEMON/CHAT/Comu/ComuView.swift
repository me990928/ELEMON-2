//
//  ContentView.swift
//  Comu
//
//  Created by 広瀬友哉 on 2023/05/25.
//

import SwiftUI

struct ComuView: View {
    
    @State var openStat: Int = 0
    
    @EnvironmentObject var fireSt: FirestoreModel
    
    var body: some View {
        VStack {
            
            if(openStat == 0){
                // グループ未作成
                if(fireSt.userflag == "true"){
                    ComuTopView()
                }else{
                    Spacer()
                    Text("設定からログインしてください")
                }
            }
            if(openStat == 1){
//                TestB()
            }
            if(openStat == 2){
//                TestC()
            }
            Spacer()
        }
    }
}

struct ContentView_Previews1123: PreviewProvider {
    static var previews: some View {
        ComuView()
    }
}
