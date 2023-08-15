//
//  HealthViewModel.swift
//  HealthItem
//
//  Created by 中島瑠斗 on 2023/06/28.
//

import Foundation
import HealthKit

final class HealthViewModel: ObservableObject {
    
    var health: Health
    var repository: HKRepository
    
    //[]はデータ型の配列
    @Published var stats = [HealthStat]()
    
    //初期化を行っている
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter
        //最後の()は、クロージャを即時に実行するための記法
    }()
    
    let dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM月"
        return formatter
        //最後の()は、クロージャを即時に実行するための記法
    }()
    
    //２つの値の初期化
    init(health: Health, repository: HKRepository){
        self.health = health
        self.repository = repository
        repository.requestHealthStat(by: health.id) { healthStats in
            //非同期で処理
            DispatchQueue.main.async {
                self.stats = healthStats
            }
        }
      }
  
    let measurementFormatter = MeasurementFormatter()
    
    func value(from stat: HKQuantity?) -> (value: Int, desc: String) {
      guard let stat = stat else { return (0, "0") }
      
        //unitStyle単位の表示スタイルを制御する
        //.long単位をフルネームで出力してくれる、プロパティを設定
      measurementFormatter.unitStyle = .long
      
      if stat.is(compatibleWith: .kilocalorie()) {
        let value = stat.doubleValue(for: .kilocalorie())
        return (Int(value), "\(Int(value))")
      } else if stat.is(compatibleWith: .meter()) {
        let value = stat.doubleValue(for: .mile())
        return (Int(value), "\(Int(value))")
      } else if stat.is(compatibleWith: .count()) {
        let value = stat.doubleValue(for: .count())
        return (Int(value),"\(Int(value))歩")
      } else if stat.is(compatibleWith: .minute()) {
        let value = stat.doubleValue(for: .minute())
        return (Int(value), "\(Int(value))")
      } else if stat.is(compatibleWith: .minute()){
          let value = stat.doubleValue(for: .minute())
          return (Int(value), "\(Int(value))")
      }
      
      return (0, "0")
    }
    
    func updateStats() {
            repository.requestHealthStat2(by: health.id) { stats in
                DispatchQueue.main.async {
                    self.stats = stats
                }
            }
        }
    
}

