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
    @State var push: Int = 0
    
    @FocusState var focus: Bool
    
    @EnvironmentObject var css: ColorThema
    @ObservedObject var accountVM = AccountViewModel()
    @EnvironmentObject var viewNum: ViewState
    
    
    @Binding var isLoading: Bool
    @Binding var accountSheet: Bool
    
    // ログインミスチェック
    @State var isMiss: Bool = false
    
    // ログイン判定
    @AppStorage ("isLogin") var isLogin: Bool = false
    
    
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
                    
                    
                    HStack {
                        Spacer()
                        Image("icon").resizable().scaledToFit().frame(width: 100,height: 100).cornerRadius(100).overlay(content: {
                            RoundedRectangle(cornerRadius: 100).stroke(Color.gray, lineWidth: 2)
                        }).aspectRatio(contentMode: .fit)
                        Spacer()
                    }
                    
                    Spacer().frame(height: item.size.height / 10)
                    if isLogin == false {
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
                        //                        self.isLoading.toggle()
                        self.push += 1
                    } label: {
                        Text("LOGIN").fontWeight(.heavy).foregroundColor(.white).frame(width: item.size.width / 2, height: 50)
                    }.background(Color(self.css.accent)).cornerRadius(10).padding(.top, 30)
                    }else{
                        HStack {
                            VStack {
                                HStack {
                                    Text("ユーザーネーム").foregroundColor(Color.gray)
                                    Spacer()
                                }
                                HStack {
                                    Text(AccountViewModel.UsersItems.name.getData).foregroundColor(Color.gray)
                                    Spacer()
                                }
                            }
                            Spacer()
                        }
                        .padding(.bottom)
                        HStack {
                            VStack {
                                HStack {
                                    Text("メールアドレス").foregroundColor(Color.gray)
                                    Spacer()
                                }
                                HStack {
                                    Text(AccountViewModel.UsersItems.mail.getData).foregroundColor(Color.gray)
                                    Spacer()
                                }
                            }
                            Spacer()
                        }
                        
                        
                        Button {
                            self.accountSheet = false
                            self.isLogin = false
                            print(AccountViewModel.UsersItems.mail.deleteData)
                            print(AccountViewModel.UsersItems.pass.deleteData)
                            print(AccountViewModel.UsersItems.name.deleteData)
                            print(AccountViewModel.UsersItems.uuid.deleteData)
                            ComuRealmModel().deleteGroup()
                        } label: {
                            Text("LOGOUT").fontWeight(.heavy).foregroundColor(.white).frame(width: item.size.width / 2, height: 50)
                        }.background(Color(self.css.accent)).cornerRadius(10).padding(.top, 30)
                    }
                    
                    Spacer()

                }.padding()
                    .onChange(of: push) { newValue in
                        self.isLoading.toggle()
                        accountVM.loginUser(mail: mail, pass: pass) { res in
                            if res {
                                // ログイン失敗
                                isMiss = true
                                self.isLoading.toggle()
                            }else{
                                isMiss = false
                                self.isLoading.toggle()
                                self.accountSheet = false
                                self.isLogin = true
                                // コミュページへ
                                viewNum.selectedTabNum = 2
                            }
                        }
                    }
            }.gesture(self.gesture)
                .onAppear(){
                    print(AccountViewModel.UsersItems.name.getData)
                }
        }
    }
}

//struct Login_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(isLoading: false).environmentObject(ColorThema())
//    }
//}
