//
//  ProgressGraf.swift
//  U22Prot0601
//
//  Created by 中島瑠斗 on 2023/06/14.
//

import SwiftUI
import Charts

struct ProgressGraf: View {

    let data: [progressCharts] = [
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
                ).foregroundStyle(point.color)
            }
        }
    }
}

struct grafView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressGraf()
    }
}
