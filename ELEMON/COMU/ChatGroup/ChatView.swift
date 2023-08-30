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
    
    @State var color: String = ""
    
    @EnvironmentObject var css: ColorThema
    
    var body: some View{
        HStack{
            if uuid == myId { Spacer() }
            Text(text).padding(.horizontal).background(Color(self.color)).cornerRadius(30).font(.body)
            if uuid != myId { Spacer() }
        }.onAppear(){
            if uuid == myId { self.color = css.accent } else { self.color = css.base }
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
    
    
    
    var body: some View {
        VStack{
            List{
                Messages(text: "text", uuid: AccountViewModel.UsersItems.uuid.getData).listRowBackground(Color.clear).listRowSeparator(.hidden)
                Messages(text: "text", uuid:"tekito").listRowBackground(Color.clear).listRowSeparator(.hidden)
                Messages(text: "text", uuid: AccountViewModel.UsersItems.uuid.getData).listRowBackground(Color.clear).listRowSeparator(.hidden)
            }.scrollContentBackground(.hidden).listStyle(.plain)
            Spacer()
            HStack {
                TextField("メッセージ", text: $text).textFieldStyle(.roundedBorder).focused($focus)
                Button {
                    
                } label: {
                    Image(systemName: "paperplane.fill").foregroundColor(Color(css.base))
                }

            }
        }.padding().gesture(self.gesture)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView().environmentObject(ColorThema())
    }
}
