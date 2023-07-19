//
//  item6.swift
//  HealthItem
//
//  Created by 中島瑠斗 on 2023/06/28.
//

//
//  item4.swift
//  page1
//
//  Created by 広瀬友哉 on 2023/05/08.
//

import SwiftUI

struct item6: View {
    
    @ObservedObject var model = ActivityModel()
    @State var color:String
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "fork.knife").font(.system(size: 40))
                Spacer()
                Text("カロリー")
                Spacer()
            }.padding(.top, 20).frame(width: 140)
            HStack{
                VStack(alignment: .leading){
                    HStack {
                        Text("現在").padding(.bottom, 5)
                        Spacer()
                        Text("\(model.nowCal)kcal")
                    }
                    HStack {
                        Text("目標").padding(.bottom, 5)
                        Spacer()
                        Text("\(model.goalCal)kcal")
                    }
                    
                }.frame(width: 140)
            }.padding(.top, 5)
            Spacer()
        }.frame(width: 170, height: 150).background(Color(color)).cornerRadius(30)
    }
}

struct item6_Previews: PreviewProvider {
    static var previews: some View {
        item6(color: "Yello")
    }
}
