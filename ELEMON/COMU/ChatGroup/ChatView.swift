//
//  ChatView.swift
//  ELEMON
//
//  Created by Yuya Hirose on 2023/08/31.
//

import SwiftUI

struct Messages: View {
    
    let text: String
    
    let uuid: String
    
    let myId: String = AccountViewModel.UsersItems.uuid.getData
    
    let name: String
    
    @EnvironmentObject var css: ColorThema
    
    var myComments: some View {
        VStack {
            HStack{
                Spacer()
                Text(name).font(.body)
            }
            HStack{
                Spacer()
                Text(text).padding(.horizontal).background(Color(css.accent)).cornerRadius(30).font(.body)
            }
        }
    }
    var gestComments: some View {
        VStack {
            HStack{
                Text(name).font(.body)
                Spacer()
            }
            HStack{
                Text(text).padding(.horizontal).background(Color(css.accent)).cornerRadius(30).font(.body)
                Spacer()
            }
        }
    }
    
    var body: some View{
        HStack{
            if uuid == myId {
                myComments
            }else{
                gestComments
            }
        }
    }
}

struct ChatView: View {
    @State var text: String = ""
    
    @EnvironmentObject var css: ColorThema
    
    @FocusState var focus:Bool
    
    var gesture: some Gesture {
        DragGesture()
            .onChanged { val in
                if val.translation.height != 0 {
                    self.focus = false
                }
            }
    }
    
    var groupid:String
    
    @ObservedObject var chatFVM:ChatModel
    
    init(groupid: String) {
        self.groupid = groupid
        _chatFVM = ObservedObject(wrappedValue: ChatModel(groupid: groupid))
    }
    
    
    var body: some View {
        VStack{
            ScrollViewReader { ScrollViewProxy in
                
                List{
                    ForEach(self.chatFVM.messages.reversed(), id: \.self) { item in
                        Messages(text: item.text, uuid: item.userId, name: item.name).listRowBackground(Color.clear).listRowSeparator(.hidden)
                    }
                    
                    Spacer().frame(height: 50).id(0).listRowBackground(Color.clear).listRowSeparator(.hidden)
                }.scrollContentBackground(.hidden).listStyle(.plain)
                    .onAppear(){
                        ScrollViewProxy.scrollTo(0)
                    }
                
                Spacer()
                HStack {
                    TextField("メッセージ", text: $text).textFieldStyle(.roundedBorder).focused($focus)
                    Button {
                        chatFVM.senfMsg(msg: text, groupId: groupid)
                        self.text = ""
                        withAnimation {
                            ScrollViewProxy.scrollTo(0)
                        }
                    } label: {
                        Image(systemName: "paperplane.fill").foregroundColor(Color(css.base))
                    }
                    
                }
            }
        }.padding().gesture(self.gesture)
    }
}

//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView(chatFVM: ChatModel).environmentObject(ColorThema())
//    }
//}
