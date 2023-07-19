//
//  ComuSetView.swift
//  page4
//
//  Created by Yuya Hirose on 2023/05/31.
//

import SwiftUI

struct ComuSetView: View {
    @EnvironmentObject var fireSt: FirestoreModel
    
    @State var alertFlag:Bool = false
    
   @State var lists:[[String]] = [
    
        ["めざせ！100万歩","true"],
        ["寝よう！30時間！","false"],
        ["ヨガパワー！3時間！","false"],
    
    ]
    
    @State var c = 0
    
    var body: some View {
        
        
        List{
            ForEach(lists, id: \.self) { val in
            Button {
                alertFlag = true
            } label: {
                HStack{
                    Text(val[0])
                    Spacer()
                }
            }.alert("変更完了！",isPresented: $alertFlag) {
                Button("OK"){
                    fireSt.changeMokuhyo(data: val[0])
                    
                }
            }
        }
    }
    }
}

struct ComuSetView_Previews: PreviewProvider {
    static var previews: some View {
        ComuSetView()
    }
}
