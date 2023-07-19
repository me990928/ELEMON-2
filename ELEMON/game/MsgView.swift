//
//  MsgView.swift
//  ELEMON
//
//  Created by Yuya Hirose on 2023/07/06.
//

import SwiftUI

struct MsgView: View {
    
    @EnvironmentObject var css:ColorThema
    
    @AppStorage ("css") var cflag = 0
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Spacer().padding(.vertical, 10)
                }
            }.frame(height: 220).background(Color( self.css.accent)).cornerRadius(10)
            VStack{
                HStack {
                    Text("こんにちは！").padding(30)
                    Spacer()
                }
                Spacer()
            }.frame(height: 200).background(Color( self.css.base)).cornerRadius(10).padding(7)
        }.onAppear(){
            css.regist(i: cflag)
        }
    }
}

struct MsgView_Previews: PreviewProvider {
    static var previews: some View {
        MsgView().environmentObject(ColorThema())
    }
}
