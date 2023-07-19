//
//  item7.swift
//  HealthItem
//
//  Created by 中島瑠斗 on 2023/06/28.
//

import SwiftUI

struct item7: View {
    
    @ObservedObject var model = ActivityModel()
    @State var color:String
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "drop").font(.system(size: 40))
                Spacer()
                Text("水分")
                Spacer()
            }.padding(.top, 20).frame(width: 140)
            HStack{
                VStack(alignment: .leading){
                    HStack {
                        Text("現在").padding(.bottom, 5)
                        Spacer()
                        Text("\(model.nowWater)ml")
                    }
                    HStack {
                        Text("目標").padding(.bottom, 5)
                        Spacer()
                        Text("\(model.goalWater)ml")
                    }
                    
                }.frame(width: 140)
            }.padding(.top, 5)
            Spacer()
        }.frame(width: 170, height: 150).background(Color(color)).cornerRadius(30)
    }
}

struct item7_Previews: PreviewProvider {
    static var previews: some View {
        item7(color: "Yello")
    }
}
