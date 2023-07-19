//
//  GroupSearchView.swift
//  Comu
//
//  Created by 広瀬友哉 on 2023/05/25.
//

import SwiftUI

struct GroupSearchView: View {
    
    @AppStorage ("groupSearch") var groupSearch: Int = 1
    @AppStorage ("groupBtn") var groupBtn: Int = 1
    
    @State var text:String = "テストメッセージ"
    @State var selectedValue:Int = 0
    @State var serchBox:Int = 0
    @State var xof:CGFloat? = nil ?? 0
    @State var alertFlag = false
    @State var alertFlag2 = false
    
    let msgStr:[String] = [
        "めざせ！100万歩",
        "寝よう！30時間！",
        "ヨガパワー！3時間！"
    ]
    
    enum Field:Hashable{
        case msg
    }
    
    @FocusState private var foc: Field?
    
    
    @EnvironmentObject var fireSt: FirestoreModel
    
    var body: some View {
        GeometryReader{ geoVal in
            HStack{
                VStack{
                    GroupBox{
                        VStack{
                            HStack{
                                Text("グループ作成").font(.title)
                                Spacer()
                            }.padding(.bottom).font(.title)
                            Spacer().frame(width: geoVal.size.width * 0.8, height: 0)
                            HStack{
                                Text("グループ名")
                                Spacer()
                                TextField("", text: $text).focused($foc, equals: .msg).textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: geoVal.size.width * 0.6)
                            }
                            HStack{
                                Text("活動方針")
                                Spacer()
                                Picker("色を選択", selection: $selectedValue) {
                                    Text(msgStr[0]).tag(0)
                                    Text(msgStr[1]).tag(1)
                                    Text(msgStr[2]).tag(2)
                                }.frame(width: geoVal.size.width * 0.5)
                            }
                            
                            Button("検索"){
                                serchBox = 1
                                fireSt.serchGroup(inputCon: msgStr[selectedValue],inputText: text)
                            }.buttonStyle(.bordered).padding()
                            
                        }
                    }
                    if(serchBox == 1){
                        ScrollView(.vertical){
                            ForEach(
                                fireSt.groups, id: \.id) {i in
                                    SerchResult(text: i.groupName, msgStr: i.context,groupId: i.appid)
                                }
//                            SerchResult(text: "test")
                        }
                    }
                }
                Spacer().frame(width: geoVal.size.width)
            }.frame(width: geoVal.size.width * 2).offset(x: xof ?? 0).animation(.default, value: xof).onTapGesture {
                foc = nil
            }
        }.onTapGesture {
            foc = nil
        }
    }
}
struct GroupSearchView_Previews: PreviewProvider {
    static var previews: some View {
        GroupSearchView()
    }
}
