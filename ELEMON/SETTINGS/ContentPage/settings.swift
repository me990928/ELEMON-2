//
//  settings.swift
//  page4
//
//  Created by 広瀬友哉 on 2023/05/09.
//

import SwiftUI

struct settings: View {
    
    @AppStorage ("loginFlag") var loginFlag: String = "0"
    @AppStorage ("groupFlag") var groupFlag: String = "0"
    @AppStorage ("groupSearch") var groupSearch: Int = 1
    @AppStorage ("groupBtn") var groupBtn: Int = 1
    @AppStorage ("groupReader") var readerFlaf: Int = 0
    @State var alertFlag:Bool = false
    @State var alertdelFlag:Bool = false
    @State var alertgdelFlag:Bool = false
    @State var alertbyeFlag:Bool = false
    
    @State var accountSheet: Bool = false
    
    @EnvironmentObject var au: FireAuthModel
    @EnvironmentObject var fireSt: FirestoreModel
    
    var account: some View {
        HStack{
            Image(systemName: "person")
            Text("アカウント")
                .padding(.leading, 10)
            Spacer()
        }
    }
    
    var body: some View {
        
        VStack{
            NavigationView {
                List {
//                    NavigationLink(destination: account().navigationTitle("アカウント") ){
//                        HStack{
//                            Image(systemName: "person")
//                            Text("アカウント")
//                                .padding(.leading, 10)
//                            Spacer()
//                        }
//                    }
                    
                    Button {
                        self.accountSheet.toggle()
                    } label: {
                        account.foregroundColor(Color(.label))
                    }
                    .sheet(isPresented: $accountSheet) {
                        AccountPage()
                    }

                    NavigationLink(destination: SwiftUIView().navigationTitle("テーマ設定") ){
                        HStack{
                            Image(systemName: "paintpalette")
                            Text("テーマ設定")
                                .padding(.leading, 10)
                            Spacer()
                        }
                    }
//                    NavigationLink(destination: Text("お問合せ") ){
//                        HStack{
//                            Image(systemName: "person.fill.questionmark")
//                            Text("お問合せ")
//                                .padding(.leading, 10)
//                            Spacer()
//                        }
//                    }
                    
                    NavigationLink(destination: PrivacyPorisy() ){
                        HStack{
                            Image(systemName: "scroll")
                            Text("利用規約")
                                .padding(.leading, 10)
                            Spacer()
                        }
                    }
                    
                    NavigationLink(destination: Pri() ){
                        HStack{
                            Image(systemName: "scroll")
                            Text("プライバシーポリシー")
                                .padding(.leading, 10)
                            Spacer()
                        }
                    }
//                    NavigationLink(destination: Text("ログアウト") ){
//                        HStack{
//                            Image(systemName: "door.right.hand.open")
//                            Text("ログアウト")
//                                .padding(.leading, 10)
//                            Spacer()
//                        }
//                    }
                    
                    
                    
                    NavigationLink(destination: InquiryFormView().navigationTitle("お問い合わせ") ){
                        // コミュビューに統合予定
                        HStack{
                            Image(systemName: "text.bubble")
                            Text("お問い合わせ")
                                .padding(.leading, 10)
                            Spacer()
                        }
                    }
                    
                    if (loginFlag=="1" && groupFlag=="1"){
                        
                        NavigationLink(destination: ComuSetView().navigationTitle("グループ目標")  ){
                            // コミュビューに統合予定
                            HStack{
                                Image(systemName: "star.bubble")
                                Text("グループ目標")
                                    .padding(.leading, 10)
                                Spacer()
                            }
                        }
                    }
                    
                    if (loginFlag=="1" && groupFlag=="1") {
                    Button {
                        alertbyeFlag = true
                    } label: {
                        HStack{
                            Image(systemName: "door.right.hand.open")
                            Text("グループ退出")
                                .padding(.leading, 10)
                            Spacer()
                        }.foregroundColor(Color(.label))
                            .alert("退出しました",isPresented: $alertbyeFlag) {
                                Button("OK"){
                                    groupFlag = "0"
                                    groupSearch = 1
                                    groupBtn = 1
                                    fireSt.messages = []
                                    fireSt.exitGroup()
                                }
                            }
                    }
                    if (readerFlaf == 1){
                        Button {
                            alertgdelFlag = true
                        } label: {
                            HStack{
                                Image(systemName: "trash")
                                Text("グループ削除")
                                    .padding(.leading, 10)
                                Spacer()
                            }.foregroundColor(.red)
                                .alert("グループを削除しました",isPresented: $alertgdelFlag) {
                                    Button("OK"){
                                        groupFlag = "0"
                                        groupSearch = 1
                                        groupBtn = 1
                                        fireSt.messages = []
                                        fireSt.delgroup()
                                    }
                                }
                        }
                    }
                }
                    
                    if (loginFlag=="1") {
                        Button {
                            
                            
                            
//                            FirestoreModel().delUser()
                            
                            alertdelFlag = true
                        } label: {
                            HStack{
                                Image(systemName: "trash")
                                Text("アカウント削除")
                                    .padding(.leading, 10)
                                Spacer()
                            }.foregroundColor(.red)
                        }
                        
                        .alert("削除しました",isPresented: $alertdelFlag) {
                            Button("OK"){
                                let appDomain = Bundle.main.bundleIdentifier
                                UserDefaults.standard.removePersistentDomain(forName: appDomain!)
                                Task{
                                    au.delete()
                                    loginFlag = "0"
                                }
                            }
                        }
                    }

                }
            }
        }
    }
}

struct settings_Previews: PreviewProvider {
    static var previews: some View {
        settings()
    }
}
