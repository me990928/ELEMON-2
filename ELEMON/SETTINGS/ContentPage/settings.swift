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
                    
                    Button {
                        self.accountSheet.toggle()
                    } label: {
                        account.foregroundColor(Color(.label))
                    }
                    .sheet(isPresented: $accountSheet) {
                        AccountPage(accountSheet: $accountSheet)
                    }

                    NavigationLink(destination: SwiftUIView().navigationTitle("テーマ設定") ){
                        HStack{
                            Image(systemName: "paintpalette")
                            Text("テーマ設定")
                                .padding(.leading, 10)
                            Spacer()
                        }
                    }
                    
//                    NavigationLink(destination: PrivacyPorisy() ){
//                        HStack{
//                            Image(systemName: "scroll")
//                            Text("利用規約")
//                                .padding(.leading, 10)
//                            Spacer()
//                        }
//                    }
//                    
//                    NavigationLink(destination: Pri() ){
//                        HStack{
//                            Image(systemName: "scroll")
//                            Text("プライバシーポリシー")
//                                .padding(.leading, 10)
//                            Spacer()
//                        }
//                    }

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
