//
//  GroupChatView.swift
//  Comu
//
//  Created by 広瀬友哉 on 2023/05/29.
//

import SwiftUI

struct selfMsg: View {
    var selfMessage:String
    
    var body: some View {
        Group {
            VStack {
                HStack {
                    Spacer()
                    Text(selfMessage).padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10)).background(.green).cornerRadius(10)
                }
            }
        }.padding()
    }
}

struct yourMsg: View {
    var yourMessage:String
    var name:String
    var body: some View {
        Group {
            VStack {
                HStack {
                    Text(name)
                    Spacer()
                }
                HStack {
                    Text(yourMessage).padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10)).background(.orange).cornerRadius(10)
                    Spacer()
                }
            }
        }.padding()
    }
}

struct msgView: View {
    var body: some View {
        VStack{
            selfMsg(selfMessage: "やあ")
            yourMsg(yourMessage: "ハロハロ",name: "noname")
        }
    }
}

struct GroupChatView: View {
    @State var sendMsg:String = ""
    
    @State var msgPre:[[String]] = [
        ["0","やあ"],
        ["1","さあ"],
        ["1","さあ"],
        ["0","さあ"],
        ["1","さあ"],
        ["1","さあ"],
    ]
    
    @Namespace var bottomID
    
    @EnvironmentObject var fireSt: FirestoreModel
    @ObservedObject var store: FirestoreModel
    
    @State var val: ScrollViewProxy?
    
    enum Field:Hashable{
        case msg
    }
    
    @FocusState private var foc: Field?
    
    @State var c = 0
    
    var body: some View {
        ScrollViewReader{ proxy in
                VStack{
                    ScrollView(showsIndicators: false){
                            Spacer()
                        ForEach(store.messages, id: \.id) { i in
                            if( i.user == fireSt.appid){
                                    selfMsg(selfMessage: i.message)
                                }else{
                                    yourMsg(yourMessage: i.message, name: i.name)
                                }
                            }
                        Spacer().frame(height: 100).id(bottomID)
                    }.onTapGesture {
                        foc = nil
                    }
                        Spacer()
                    
                    ZStack {
                        HStack {
                            TextField("", text: $sendMsg).textFieldStyle(.roundedBorder).focused($foc, equals: .msg)
                            Button("送信"){
                                if(sendMsg != ""){
                                    fireSt.addmsg(msg: sendMsg)
                                    msgPre.append(contentsOf: [["0",sendMsg]])
                                    sendMsg = ""
                                    proxy.scrollTo(bottomID)
                                }
                            }.buttonStyle(.borderedProminent)
                        }.padding()
                    }
                }.onTapGesture {
                    foc = nil
                }
        }
    }
}

struct GroupChatView_Previews: PreviewProvider {
    static var previews: some View {
        GroupChatView(store: FirestoreModel())
    }
}
