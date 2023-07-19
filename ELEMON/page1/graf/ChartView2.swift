//
//  ChartView2.swift
//  HealthItem
//
//  Created by 中島瑠斗 on 2023/06/28.
//

import SwiftUI
import Charts
import HealthKit

struct ChartView2: View {
  let stats: [HealthStat]
  var health: Health
  @ObservedObject var viewModel: HealthViewModel
  
  var body: some View {
        Chart {
          
          ForEach(stats) { stat in
            BarMark(x: .value("Days", viewModel.dateFormatter.string(from: stat.date)),
                    y: .value("Values", viewModel.value(from: stat.stat).value)
            )
            .foregroundStyle(Color.pink.gradient)
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

  }

}

struct ChartView2_Previews: PreviewProvider {
  static var previews: some View {
    ChartView2(stats: [HealthStat(stat: HKQuantity(unit: .count(), doubleValue: .pi), date: Date())], health: Health(id: "stepCount", name: "Step Count", image: "👣"), viewModel: HealthViewModel(health: Health(id: "steps", name: "Steps", image: "👣"), repository: HKRepository()))
  }
}

