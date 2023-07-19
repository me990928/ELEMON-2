//
//  SwiftUIView.swift
//  page1
//
//  Created by 広瀬友哉 on 2023/05/08.
//

import SwiftUI
import Charts

struct GrafView: View {
    
    var pointColor: String

    let data: [charts] = [
        .init(title: "day1", value: 10),
        .init(title: "day2", value: 20),
        .init(title: "day3", value: 40),
        .init(title: "day4", value: 10),
        .init(title: "day5", value: 20),
        .init(title: "day6", value: 40),
        .init(title: "day7", value: 30)
    ]
    
    
    var body: some View {
        VStack{
            Chart(data){ point in
                BarMark(
                    x: .value("title", point.title),
                    y: .value("name", point.value)
                ).foregroundStyle(Color("\(pointColor)"))
            }
        }
    }
}

struct GrafView_Previews: PreviewProvider {
    static var previews: some View {
        GrafView(pointColor: "gradEndRed")
    }
}
