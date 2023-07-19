//
//  SleepChartView.swift
//  HealthItem
//
//  Created by 中島瑠斗 on 2023/07/02.
//

import SwiftUI
import Charts

struct SleepChartView: View {
    var sleepTime: [SleepGraf]
    
    
    var body: some View {
        Chart {
            ForEach(sleepTime) { sleep in
                let hourSleep = HourSleep(sleep: sleep.value)
                // "分"の前の数字を取得
                let minuSleep = MinuSleep(sleep: sleep.value)
                
                let totalSleep = hourSleep + minuSleep/60
                BarMark(
                    x: .value("Days", sleep.date),
                    y: .value("Value", totalSleep)
                ).foregroundStyle(Color.pink.gradient)
                    .cornerRadius(2) // 0 for no conerRadius or some value
                    .interpolationMethod(.catmullRom)
                //                    .annotation(position: .top, alignment: .center, spacing: 10) {
                //                        Text("\(sleep.value)")
                //                            .foregroundColor(.white)
                //                            .rotationEffect(.degrees(-60))
                //                    }
                
                
            }
        }
        .chartYScale(domain: .automatic(includesZero: false))
        //.chartYScale(domain: yAxisScale(health))
        .chartYAxis {
            AxisMarks(position: .trailing) {mark in // position is leading, trailing
                AxisValueLabel(anchor: UnitPoint(x: 0, y: 1)) {
                    if let doubleValue = mark.as(Double.self) {
                        if ( doubleValue < 1 && doubleValue > 0 ){
                            Text(String(format: "%.01時間", doubleValue))
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }else{
                            Text(String(format: "%.0f時間", doubleValue))
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }

                    }
                }
                AxisGridLine()
            }
        }
    }
    func yAxisScale(_ health: Health) -> ClosedRange<Int> {
        return 0...6
    }
    
    func HourSleep(sleep:String) ->Double{
        if let hourRange = sleep.range(of: "時間") {
            let startIndex = sleep.startIndex
            let endIndex = hourRange.lowerBound
            let hourSubstring = sleep[startIndex..<endIndex].trimmingCharacters(in: .whitespacesAndNewlines)
            if let hour = Double(hourSubstring) {
                return hour
            }
        }
        return 0
    }
    
    func MinuSleep(sleep:String) ->Double{
        if let minuteRange = sleep.range(of: "分") {
            let endIndex = minuteRange.lowerBound
            let startIndex = sleep[..<endIndex].lastIndex { $0.isNumber == false }
            if let startIndex = startIndex {
                let minuteSubstring = sleep[sleep.index(after: startIndex)..<endIndex].trimmingCharacters(in: .whitespacesAndNewlines)
                if let minute = Double(minuteSubstring) {
                    return minute
                }
            }
        }
        return 0
    }
}

