//
//  HealthStat.swift
//  HealthItem
//
//  Created by 中島瑠斗 on 2023/06/28.
//

import Foundation
import HealthKit

struct HealthStat: Identifiable {
  let id = UUID()
  let stat: HKQuantity?
  let date: Date
}
