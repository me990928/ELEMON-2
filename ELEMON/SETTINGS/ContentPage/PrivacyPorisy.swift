//
//  PrivacyPorisy.swift
//  page4
//
//  Created by 広瀬友哉 on 2023/05/30.
//

import SwiftUI

struct PrivacyPorisy: View {
    var body: some View {
        VStack{
            HStack {
                Image(systemName: "doc.text")
                Text("利用規約")
                Spacer()
            }.padding().font(.title)
            GroupBox{
                VStack{
                    HStack{Spacer()}
                    Text("この利用規約（以下、「本規約」といいます）は、XXXサービス（以下、「当サービス」といいます）の利用条件を定めるものです。当サービスを利用することにより、利用者は本規約に同意したものとみなされます。利用者は、本規約に従って当サービスを利用するものとします。")
                    ScrollView{
                        Text("\n1. 利用者の責任と義務\n\n1.1 利用者は、当サービスを適法かつ誠実に利用することを責任と義務とします。\n\n1.2 利用者は、当サービスを自己の責任において利用するものとし、当サービスの利用に関連して発生するすべてのリスクに対して責任を負うものとします。\n\n1.3 利用者は、当サービスを利用するにあたり、法令や第三者の権利を侵害する行為を行ってはならず、他の利用者や第三者に迷惑や損害を与える行為を行ってはなりません。\n\n 2. 知的財産権\n\n2.1 当サービスに関するすべての知的財産権は、当サービスを提供する会社に帰属します。\n\n2.2 利用者は、当サービスの提供を受けることによって、当サービスに関する知的財産権を取得するものではありません。\n\n3. 個人情報の取扱い\n\n3.1 利用者が当サービスを利用するために提供する個人情報は、プライバシーポリシーに従って取り扱われます。\n\n3.2 当サービスを通じて収集された個人情報は、法令に従って適切に保護され、利用者の同意なく第三者に提供されることはありません。\n\n4. 免責事項\n\n4.1 当サービスは、現状のまま提供されるものであり、特定の目的への適合性やエラーの修正を保証するものではありません。\n\n4.2 当サービスの利用によって発生したいかなる責任を保証致しかねます。").padding(.horizontal)
                    }.padding(.vertical).background(.white).cornerRadius(10).foregroundColor(Color(.black))
                }
            }.padding()
        }
    }
}

struct PrivacyPorisy_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPorisy()
    }
}
