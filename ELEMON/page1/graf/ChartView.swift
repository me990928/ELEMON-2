//
//  ChartView.swift
//  HealthItem
//
//  Created by 中島瑠斗 on 2023/06/28.
//

import SwiftUI
import Charts
import HealthKit

struct ChartView: View {
  let stats: [HealthStat]
  var health: Health
    let color: Color
  @ObservedObject var viewModel: HealthViewModel
  
  var body: some View {
        Chart {
//          RuleMark(y: .value("Goal", 500))
//            .foregroundStyle(Color.mint)
//            .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
//            .annotation(alignment: .leading) {
//              Text("Goal")
//                .font(.caption)
//                .foregroundColor(.secondary)
//            }
          
          ForEach(stats) { stat in
            BarMark(x: .value("Days", viewModel.dateFormatter.string(from: stat.date)),
                    y: .value("Values", viewModel.value(from: stat.stat).value)
            )
            .foregroundStyle(color)
            .cornerRadius(2) // 0 for no conerRadius or some value
            .annotation(position: .top, alignment: .center, spacing: 10) {
              Text("\(viewModel.value(from: stat.stat).value)")
                .foregroundColor(.white)
                .rotationEffect(.degrees(-60))
            }
          }
        }
        .chartYScale(domain: .automatic(includesZero: false))
        //.chartYScale(domain: yAxisScale(health))
        .chartYAxis {
          AxisMarks(position: .trailing) {mark in // position is leading, trailing
            AxisValueLabel()
            AxisGridLine()
          }
        }
//        .chartPlotStyle { plotContent in
//          plotContent
//            .background(.mint.gradient.opacity(0.34))
//            .border(.green, width: 1)
//        }
  }
  
//  func yAxisScale(_ health: Health) -> ClosedRange<Int> {
//    switch health.id {
//      case "activeEnergyBurned":
//        return 0...700
//      case "appleExerciseTime":
//        return 0...100
//      case "appleStandTime":
//        return 0...100
//      case "distanceWalkingRunning":
//        return 0...5
//      case "stepCount":
//        return 0...11000
//      case "heartRate":
//        return 0...100
//      default: return 0...1000
//    }
//  }
}

struct ChartView_Previews: PreviewProvider {
  static var previews: some View {
      ChartView(stats: [HealthStat(stat: HKQuantity(unit: .count(), doubleValue: .pi), date: Date())], health: Health(id: "stepCount", name: "Step Count", image: "👣"), color: Color.red, viewModel: HealthViewModel(health: Health(id: "steps", name: "Steps", image: "👣"), repository: HKRepository()))
  }
}

