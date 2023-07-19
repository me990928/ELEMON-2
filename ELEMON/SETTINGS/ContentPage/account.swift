//
//  account.swift
//  page4
//
//  Created by 広瀬友哉 on 2023/05/09.
//

import SwiftUI

struct account: View {
    @AppStorage ("loginFlag") var loginFlag: String = "0"
    @AppStorage ("registFlag") var registFlag: Bool = true
    @AppStorage ("userName") var userName: String = ""
    @AppStorage ("userMail") var userMail: String = ""
    @AppStorage ("userPass") var userPass: String = ""

    @EnvironmentObject var auth: FireAuthModel
    @EnvironmentObject var store: FirestoreModel
    
    @State var alert: String = "登録"
    
    var body: some View {
        VStack{
            GroupBox{
                HStack{
                    Image(systemName: "person")
                        .padding(.horizontal)
                    Text("アカウント")
                    Spacer()
                }.font(.title)
                
                VStack(alignment: .leading){
                    Text("ユーザ名")
//                    Spacer()
                    if(loginFlag=="0"){
                        HStack {
                            TextField("登録する場合は入力してください", text: self.$userName).textFieldStyle(.roundedBorder)
                            Spacer()
                        }
                    }else{
                        HStack {
                            Text(auth.getUserinfo(get: "name")).foregroundColor(Color(.label))
                            Spacer()
                        }
                    }
                }.padding([.top, .leading, .trailing])
                
                VStack(alignment: .leading){
                    HStack{
                        Text("メールアドレス")
                        Spacer()
                    }
//                    Spacer()
                    if(loginFlag=="0"){
                        TextField("Mail address", text: self.$userMail).textFieldStyle(.roundedBorder)
                    }else{
                        Text(auth.getUserinfo(get: "emil")).foregroundColor(Color(.label))
                    }
                }.padding([.top, .leading, .trailing])
                VStack(alignment: .leading){
                        if(loginFlag=="0"){
                        Text("パスワード")
//                        Spacer()
                        SecureField("Password", text: self.$userPass).textFieldStyle(.roundedBorder)
                    }
                }.padding()
                HStack {
                    Spacer()
                    if(loginFlag == "0"){
                        if(auth.registFlag == true && registFlag == true){
                            Button(alert){
                                if(userMail.count > 0 && userName.count > 0 &&
                                   userPass.count > 0){
                                    
                                    Task {
                                         auth.registUser(mail: userMail, pass: userPass, name: userName)
                                        
//                                        store.addusr(name: userName, mail: userMail, pass: userPass, group: "")
                                    }
                                    
                                }
                                print(registFlag)
//                                alert = "失敗"
                            }.buttonStyle(.borderedProminent)
                        }else{
                            Text("登録完了")
                        }
                        Button("ログイン"){
                            
                            Task {
                                await loginFlag = try auth.signin(email: userMail, pass: userPass)
                                store.userflag = "true"
                            }
                            
//                                loginFlag = "1"
                            
                        }.buttonStyle(.borderedProminent)
                    }else{
                        Button("ログアウト"){
                            auth.logout()
                            loginFlag = "0"
                            registFlag = true
                            auth.registFlag = true
                            userMail = ""
                            userName = ""
                            userPass = ""
                            alert = "登録"
                            store.userflag = "false"
                        }.buttonStyle(.borderedProminent)
                    }
                    // ログアウトを押したらloginflagを0にする
                }.padding(.trailing)
            }.padding()
        }
    }
}

struct account_Previews: PreviewProvider {
    static var previews: some View {
        account().environmentObject(FireAuthModel()).environmentObject(FirestoreModel())
    }
}
