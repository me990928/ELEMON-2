//
//  item5.swift
//  HealthItem
//
//  Created by 中島瑠斗 on 2023/06/28.
//

import SwiftUI

struct item5: View {
    
    @ObservedObject var model = ActivityModel()
    @State var color:String
    @AppStorage ("heart") var heartRate: Double = 0.0
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "waveform.path.ecg").font(.system(size: 40))
                Spacer()
                Text("心拍数")
                Spacer()
            }.padding(.top, 20).frame(width: 140)
            HStack{
                VStack(alignment: .leading){
                    HStack {
                        Text("現在の心拍数").padding(.bottom, 1)
                        Spacer()
                        //Text(model.stepCount)
                    }
                    HStack {
                        Spacer()
                        Text("\(heartRate, specifier: "%.0f") bpm").padding(.bottom, 5)
                    }
                    
                }.frame(width: 140)
            }.padding(.top, 5)
            Spacer()
        }.frame(width: 170, height: 150).background(Color(color)).cornerRadius(30)
    }
}

struct item5_Previews: PreviewProvider {
    static var previews: some View {
        item5(color: "Yello")
    }
}
