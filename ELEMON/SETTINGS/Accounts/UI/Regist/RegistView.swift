//
//  RegistView.swift
//  ELEMONChatApp
//
//  Created by Yuya Hirose on 2023/08/09.
//

import SwiftUI

struct RegistView: View {
    
    @FocusState var focus:Bool
    
    @State var name: String = ""
    @State var mail: String = ""
    @State var pass: String = ""
    @Binding var isResist: Bool
    
    @EnvironmentObject var css: ColorThema
    
    var gesture: some Gesture {
        DragGesture()
            .onChanged { val in
                if val.translation.height != 0 {
                    self.focus = false
                }
            }
    }
    
    var body: some View {
        ZStack {
            GeometryReader { item in
                VStack{
                    
                    
    //                Image("icon").resizable().scaledToFit().frame(width: 100,height: 100).cornerRadius(100).overlay(content: {
    //                    RoundedRectangle(cornerRadius: 100).stroke(Color.gray, lineWidth: 2)
    //                }).aspectRatio(contentMode: .fit)
                    
                    Spacer().frame(height: item.size.height / 10)
                    
                    Group {
                        HStack {
                            Text("ユーザー名").foregroundColor(Color.gray)
                            Spacer()
                        }
                        TextField("UserName", text: $name).textFieldStyle(.roundedBorder).padding(.bottom, 10).focused($focus)
                        
                        HStack {
                            Text("メールアドレス").foregroundColor(Color.gray)
                            Spacer()
                        }
                        TextField("MailAddress", text: $mail).textFieldStyle(.roundedBorder).padding(.bottom, 10).focused($focus)
                        HStack {
                            Text("パスワード").foregroundColor(Color.gray)
                            Spacer()
                        }
                        TextField("Password", text: $pass).textFieldStyle(.roundedBorder).focused($focus)
                        Button {
                            self.isResist.toggle()
                        } label: {
                            Text("REGIST").fontWeight(.heavy).foregroundColor(.white).frame(width: item.size.width / 2, height: 50)
                        }.background(Color(self.css.accent)).cornerRadius(10).padding(.top, 30)
                    }
                    
                    Spacer()

                }.padding()
            }.gesture(self.gesture)
        }
    }
}

//struct RegistView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegistView().environmentObject(ColorThema())
//    }
//}
