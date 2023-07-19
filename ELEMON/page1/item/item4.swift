//
//  item4.swift
//  page1
//
//  Created by 広瀬友哉 on 2023/05/08.
//

import SwiftUI

struct item4: View {
    
    @ObservedObject var model = ActivityModel()
    @State var color:String
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "figure.walk").font(.system(size: 40))
                Spacer()
                Text("身体測定値")
                Spacer()
            }.padding(.top, 20).frame(width: 140)
            HStack{
                VStack(alignment: .leading){
                    HStack {
                        Text("体重").padding(.bottom, 5)
                        Spacer()
                        Text(String(format: "%.1fkg", model.weight))
                    }
                    HStack {
                        Text("BMI").padding(.bottom, 5)
                        Spacer()
                        Text("\(model.bmi)")
                    }
                    
                }.frame(width: 140)
            }.padding(.top, 5)
            Spacer()
        }.frame(width: 170, height: 150).background(Color(color)).cornerRadius(30)
    }
}

struct item4_Previews: PreviewProvider {
    static var previews: some View {
        item4(color: "Yello")
    }
}
