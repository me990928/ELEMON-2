//
//  item1.swift
//  page1
//
//  Created by 広瀬友哉 on 2023/05/08.
//

import SwiftUI

struct item1: View {
    
    @ObservedObject var model = ActivityModel()
    @EnvironmentObject var healthSleep: HealthSleep
    @State var color:String
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "bed.double").font(.system(size: 40))
                Spacer()
                Text("睡眠")
                Spacer()
            }.padding(.top, 20).frame(width: 140)
            HStack{
                VStack(alignment: .leading){
                    HStack {
                        Text("睡眠時間").padding(.bottom, 5)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("\(model.sleepTime)")
//                        Text("昨日睡眠").padding(.bottom, 5)
//                        Spacer()
//                        Text("")
                    }
                    
                }.frame(width: 140)
            }.padding(.top, 5)
            Spacer()
        }.frame(width: 170, height: 150).background(Color(color)).cornerRadius(30)
    }
}

struct item1_Previews: PreviewProvider {
    static var previews: some View {
        item1(color: "Yello")
    }
}
