//
//  EatsSheet.swift
//  game
//
//  Created by 広瀬友哉 on 2023/06/27.
//

import SwiftUI

struct EatsSheet: View {
    
    var char = CharModel()
    
    @State var eatFlag:Bool = false
    
    var body: some View {
        VStack{
                Button {
                    print("ご飯")
                    char.eatRice()
                    char.downHealth()
                    eatFlag = true
                } label: {
                    HStack{
                        Image(systemName: "frying.pan").padding(.trailing, 30)
                        Text("ご飯")
                        Spacer()
                    }
                }.padding(30).font(.title)
                .alert(isPresented: $eatFlag) {
                    Alert(title: Text("ご馳走様！"))
                }
                
                Button {
                    print("おやつ")
                    char.eatSweet()
                    char.downHealth()
                    eatFlag=true
                } label: {
                    HStack{
                        Image(systemName: "popcorn").padding(.trailing,30)
                        Text("おやつ")
                        Spacer()
                    }.padding(30).font(.title)
                }
        }
    }
}

struct EatsSheet_Previews: PreviewProvider {
    static var previews: some View {
        EatsSheet()
    }
}
