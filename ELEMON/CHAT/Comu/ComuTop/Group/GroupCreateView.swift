//
//  GroupCreateView.swift
//  Comu
//
//  Created by 広瀬友哉 on 2023/05/29.
//

import SwiftUI

struct GroupCreateView: View {
    
    @EnvironmentObject var fireSt: FirestoreModel
    
    @AppStorage ("groupSearch") var groupSearch: Int = 1
    @AppStorage ("groupBtn") var groupBtn: Int = 1
    
    @AppStorage ("groupFlag") var groupFlag: String = "0"
    
    @AppStorage ("groupReader") var readerFlaf: Int = 0
    
    @State var text1:String = ""
    @State var text2:String = ""
    @State var selectedValue:Int = 0
    @State var alertFlag = false
    
    
    let msgStr:[String] = [
        "めざせ！100万歩",
        "寝よう！30時間！",
        "ヨガパワー！3時間！"
    ]
    
    var body: some View {
        GroupBox{
            VStack{
                HStack{
                    Text("グループ作成")
                    Spacer()
                }.padding()
                Group{
                    HStack{
                        Text("グループ名")
                        TextField("", text: $text1).textFieldStyle(.roundedBorder)
                    }
                    HStack{
                        Text("グループID")
                        TextField("", text: $text2).textFieldStyle(.roundedBorder)
                    }
                    
                    
                    HStack{
                        Text("活動方針")
                        Spacer()
                        Picker("色を選択", selection: $selectedValue) {
                            Text(msgStr[0]).tag(0)
                            Text(msgStr[1]).tag(1)
                            Text(msgStr[2]).tag(2)
                        }
                    }
                    
                }.padding()
                Button {
                    print("a")
                    if(text1 == ""){
                        text1 = "名無し"
                    }
                    if(text2 == ""){
                        text2 = fireSt.appid
                    }
                    alertFlag = true
                } label: {
                    Text("作成")
                }.buttonStyle(.bordered).padding()
                .alert("本当に作成しますか？", isPresented: $alertFlag) {
                    Button("YES"){
                        groupSearch = 2
                        groupBtn = 0
                        groupFlag = "1"
                        fireSt.addGroup(name: text1, gid: text2, tex: msgStr[selectedValue])
                        readerFlaf = 1
                    }
                    Button("NO",role: .cancel){}
                }
                }
            }
        }
    }


struct GroupCreateView_Previews: PreviewProvider {
    static var previews: some View {
        GroupCreateView()
    }
}
