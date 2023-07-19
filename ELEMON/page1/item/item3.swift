//
//  item3.swift
//  page1
//
//  Created by 広瀬友哉 on 2023/05/08.
//

//
//  item1.swift
//  page1
//
//  Created by 広瀬友哉 on 2023/05/08.
//

import SwiftUI

struct item3: View {
    
    @ObservedObject var model = ActivityModel()
    @EnvironmentObject var healthSleep: HealthSleep
    @State var color:String
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "figure.mind.and.body").font(.system(size: 40))
                Spacer()
                Text("マインドフルネス")
                Spacer()
            }.padding(.top, 20).frame(width: 140)
            HStack{
                VStack(alignment: .leading){
                    HStack {
                        Text("瞑想時間").padding(.bottom, 5)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("\(model.mindTime)")
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

struct item3_Previews: PreviewProvider {
    static var previews: some View {
        item3(color: "Yello")
    }
}
