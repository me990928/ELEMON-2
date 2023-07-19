//
//  item8.swift
//  HealthItem
//
//  Created by 中島瑠斗 on 2023/06/28.
//

import SwiftUI

struct item8: View {
    
    @ObservedObject var model = ActivityModel()
    @State var color:String
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "flame").font(.system(size: 40))
                Spacer()
                Text("アクティビティ")
                Spacer()
            }.padding(.top, 20).frame(width: 140)
            HStack{
                VStack(alignment: .leading){
                    HStack {
                        Text("ムーブ").padding(.bottom, 5)
                        Spacer()
                        Text("\(model.nowMove)kcal")
                    }
                    HStack {
                        Text("スタンド").padding(.bottom, 5)
                        Spacer()
                        Text("\(model.nowStand)時間")
                    }
                    
                }.frame(width: 140)
            }.padding(.top, 5)
            Spacer()
        }.frame(width: 170, height: 150).background(Color(color)).cornerRadius(30)
    }
}

struct item8_Previews: PreviewProvider {
    static var previews: some View {
        item8(color: "Yello")
    }
}
