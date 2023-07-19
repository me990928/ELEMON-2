//
//  SwiftUIView.swift
//  page1
//
//  Created by 広瀬友哉 on 2023/05/15.
//

import SwiftUI
import Charts

struct LineMarke: View {
    var pointColor:String
    var body: some View {
        
        let data: [charts] = [
            .init(title: "7h", value: 10),
            .init(title: "6h", value: 20),
            .init(title: "5h", value: 40),
            .init(title: "4h", value: 10),
            .init(title: "3h", value: 20),
            .init(title: "2h", value: 40),
            .init(title: "1h", value: 30)
        ]
        
        VStack{
            Chart(data) {
                LineMark(
                    x: .value("", $0.title),
                    y: .value("", $0.value)
                )
            }.foregroundColor(Color("\(pointColor)"))
        }
    }
}

struct SwiftUIView_Previews123: PreviewProvider {
    static var previews: some View {
        LineMarke(pointColor: "gradEndRed")
    }
}
