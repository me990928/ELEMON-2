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
    
    var accountVM = AccountViewModel()
    
    @State var inputChecked: Bool = true
    @State var push: Bool = false
    
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
                        
                        if inputChecked == false {
                            HStack {
                                Text("未入力項目が存在します").foregroundColor(.red)
                                Spacer()
                            }.padding(.top)
                        }
                        
                        Button {
                            self.push = true
                            
                            print("tuukaaa-\(accountVM.isValidEmail(email: self.mail))")
                        } label: {
                            Text("REGIST").fontWeight(.heavy).foregroundColor(.white).frame(width: item.size.width / 2, height: 50)
                        }.background(Color(self.css.accent)).cornerRadius(10).padding(.top, 30)
                    }.onChange(of: push) { _ in
                        // 入力チェック
                        if accountVM.inputCheck(data: self.name) || !(accountVM.isValidEmail(email: self.mail)) || accountVM.inputCheck(data: self.pass) {
                            self.inputChecked = false
                        }else{
                            self.inputChecked = true
                        }
                        self.push = false
                    }
                    .onChange(of: inputChecked) { _ in
                        if self.inputChecked {
                            print("tuuka-\(self.inputChecked)")
                            self.isResist.toggle()
                        }
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
