//
//  Login.swift
//  ELEMONChatApp
//
//  Created by Yuya Hirose on 2023/08/09.
//

import SwiftUI
// メールアドレス
// パスワード
struct LoginView: View {
    @State var mail: String = ""
    @State var pass: String = ""
    
    @State var push: Bool = false
    
    @FocusState var focus: Bool
    
    @EnvironmentObject var css: ColorThema
    
    @Binding var isLoading: Bool
    
    // ログインミスチェック
    @State var isMiss: Bool = true
    
    
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
                    
                    Spacer().frame(height: item.size.height / 15)
                    
                    
                    Image("icon").resizable().scaledToFit().frame(width: 100,height: 100).cornerRadius(100).overlay(content: {
                        RoundedRectangle(cornerRadius: 100).stroke(Color.gray, lineWidth: 2)
                    }).aspectRatio(contentMode: .fit)
                    
                    Spacer().frame(height: item.size.height / 10)
                    
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
                    
                    if isMiss {
                        HStack {
                            Text("ログイン失敗").foregroundColor(.red)
                            Spacer()
                        }.padding(.top)
                    }
                    
                    Button {
                        self.isLoading.toggle()
                    } label: {
                        Text("LOGIN").fontWeight(.heavy).foregroundColor(.white).frame(width: item.size.width / 2, height: 50)
                    }.background(Color(self.css.accent)).cornerRadius(10).padding(.top, 30)
                    
                    
                    Spacer()

                }.padding()
            }.gesture(self.gesture)
        }
    }
}

//struct Login_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(isLoading: false).environmentObject(ColorThema())
//    }
//}
