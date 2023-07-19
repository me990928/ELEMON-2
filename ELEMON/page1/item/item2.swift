//
//  item2.swift
//  page1
//
//  Created by 広瀬友哉 on 2023/05/08.
//

import SwiftUI

struct item2: View {
    
    @ObservedObject var model = ActivityModel()
    @State var color:String
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "figure.walk").font(.system(size: 40))
                Spacer()
                Text("歩数")
                Spacer()
            }.padding(.top, 20).frame(width: 140)
            HStack{
                VStack(alignment: .leading){
                    HStack {
                        Text("今日の歩数").padding(.bottom, 1)
                        Spacer()
                        //Text(model.stepCount)
                    }
                    HStack {
                        Spacer()
                        Text(model.stepCount).padding(.bottom, 5)
//                        Text("昨日").padding(.bottom, 5)
//                        Spacer()
//                        Text("12,345歩")
                    }
                    
                }.frame(width: 140)
            }.padding(.top, 5)
            Spacer()
        }.frame(width: 170, height: 150).background(Color(color)).cornerRadius(30)
    }
}

struct item2_Previews: PreviewProvider {
    static var previews: some View {
        item2(color: "Yello")
    }
}
