//
//  SerchResult.swift
//  chattest
//
//  Created by Yuya Hirose on 2023/06/12.
//

import SwiftUI

struct SerchResult: View {
    
    @AppStorage ("groupSearch") var groupSearch: Int = 1
    @AppStorage ("groupBtn") var groupBtn: Int = 1
    
    @AppStorage ("groupFlag") var groupFlag: String = "0"
    
    @State var text:String
    @State var selectedValue:Int = 0
    @State var serchBox:Int = 0
    @State var xof:CGFloat? = nil ?? 0
    @State var alertFlag = false
    @State var alertFlag2 = false
    
    let msgStr:String
    
    let groupId:String
    
    @EnvironmentObject var fireSt: FirestoreModel
    
    var body: some View {
        GroupBox{
            VStack{
                Button {
//                                    xof = -(geoVal.size.width)
                    alertFlag = true
                } label: {
                    VStack{
//                        Spacer().frame(width: geoVal.size.width * 0.9, height: 0)
                        HStack{
                            Image(systemName: "person.fill").font(.title).frame(width: 30).padding()
                            VStack{
                                HStack {
                                    Text("グループ名：\(text)")
                                    Spacer()
                                }
                                HStack {
                                    Text("活動方針：\(msgStr)")
                                    Spacer()
                                }
                            }
                        }
                    }
                }.padding(.top).foregroundColor(Color(.label))
                    .alert("このグループに参加しますか？", isPresented: $alertFlag) {
                        Button("YES"){
                            print(groupId)
                            fireSt.joinGroup(groupName: text, groupId: groupId, mokuhyo: msgStr)
                            groupSearch = 2
                            groupBtn = 0
                            groupFlag = "1"
                        }
                        Button("NO", role: .cancel){
                            print("やあ")
                        }
                    }
                
            }
        }.padding(.top)
    }
}

struct SerchResult_Previews: PreviewProvider {
    static var previews: some View {
        SerchResult(text: "test",msgStr: "test",groupId: "test")
    }
}
