//
//  CreateGroup.swift
//  ELEMON
//
//  Created by Yuya Hirose on 2023/08/30.
//

import SwiftUI

struct CreateGroup: View {
    @State var roomName: String = ""
    @State var context: String = ""
    
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
        GeometryReader { item in
            VStack{
                Spacer()
                HStack{
                    Text("ルーム名").foregroundColor(.gray)
                    Spacer()
                }
                HStack{
                    TextField("ルーム名", text: $roomName).textFieldStyle(.roundedBorder).focused($focus)
                }.padding(.bottom)
                HStack{
                    Text("説明").foregroundColor(.gray)
                    Spacer()
                }
                HStack{
                    TextField("説明", text: $context).textFieldStyle(.roundedBorder).focused($focus)
                }
                
                Button {
                    
                } label: {
                        Text("REGIST").fontWeight(.heavy).foregroundColor(.white).frame(width: item.size.width / 2, height: 50)
                }.background(Color(self.css.accent)).cornerRadius(10).padding(.top, 30)
                
                Spacer()
            }.padding().presentationDetents([.medium])
        }
    }
}

struct CreateGroup_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroup().environmentObject(ColorThema())
    }
}
