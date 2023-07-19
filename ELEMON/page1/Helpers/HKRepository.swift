//
//  HKRepository.swift
//  HealthItem
//
//  Created by 中島瑠斗 on 2023/06/28.
//

import Foundation
import HealthKit

final class HKRepository {
    var store: HKHealthStore?
    
    let allTypes = Set([
      HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
      HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
      HKObjectType.quantityType(forIdentifier: .appleStandTime)!,
      HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
      HKObjectType.quantityType(forIdentifier: .stepCount)!,
      HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!,
      HKObjectType.quantityType(forIdentifier: .heartRate)!,
      HKObjectType.quantityType(forIdentifier: .bodyMass)!,
      HKQuantityType.quantityType(forIdentifier: .height)!,
      HKCategoryType.categoryType(forIdentifier: .mindfulSession)!,
      HKObjectType.quantityType(forIdentifier: .bodyMassIndex)!,
    ])
    let typesToShare = Set([
        HKQuantityType.quantityType(forIdentifier: .height)!,
        HKObjectType.quantityType(forIdentifier: .bodyMass)!,
        HKObjectType.quantityType(forIdentifier: .bodyMassIndex)!,
    ])
    
    var query: HKStatisticsCollectionQuery?
    
    init() {
      store = HKHealthStore()
    }
    func requestAuthorization(completion: @escaping (Bool) -> ()) {
      guard let store = store else { return }
      store.requestAuthorization(toShare: typesToShare, read: allTypes) { success, error in
        completion(success)
      }
    }
}

extension HKRepository {
    
    func requestHealthStat(by category: String, completion: @escaping ([HealthStat]) -> ()) {
      guard let store = store,
            let type = HKObjectType.quantityType(forIdentifier: typeByCategory(category: category)) else { return }
      let startDate = Calendar.current.date(byAdding: .day, value: -6, to: Date()) ?? Date()
      let endDate = Date()
      let anchorDate = Date.firstDayOfWeek()
      let dailyComponent = DateComponents(day: 1)
      
      var healthStats = [HealthStat]()
      
      let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
      
      query = HKStatisticsCollectionQuery(quantityType: type, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: dailyComponent)
      
      query?.initialResultsHandler = { query, statistics, error in
        statistics?.enumerateStatistics(from: startDate, to: endDate, with: { stats, _ in
          let stat = HealthStat(stat: stats.sumQuantity(), date: stats.startDate)
          healthStats.append(stat)
        })
        completion(healthStats)
      }
      guard let query = query else { return }
      store.execute(query)
    }
    
    func requestHealthStat2(by category: String, completion: @escaping ([HealthStat]) -> ()) {
      guard let store = store,
            let type = HKObjectType.quantityType(forIdentifier: typeByCategory(category: category)) else { return }
      let startDate = Calendar.current.date(byAdding: .month, value: -6, to: Date()) ?? Date()
      let endDate = Date()
      let anchorDate = Date.firstDayOfWeek()
        let dailyComponent = DateComponents(month: 1)
      
      var healthStats = [HealthStat]()
      
      let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
      
      query = HKStatisticsCollectionQuery(quantityType: type, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: dailyComponent)
      
      query?.initialResultsHandler = { query, statistics, error in
        statistics?.enumerateStatistics(from: startDate, to: endDate, with: { stats, _ in
          let stat = HealthStat(stat: stats.sumQuantity(), date: stats.startDate)
          healthStats.append(stat)
        })
        completion(healthStats)
      }
      guard let query = query else { return }
      store.execute(query)
    }
    
    private func typeByCategory(category: String) -> HKQuantityTypeIdentifier {
      switch category {
        case "activeEnergyBurned":
          return .activeEnergyBurned
        case "appleExerciseTime":
          return .appleExerciseTime
        case "appleStandTime":
          return .appleStandTime
        case "distanceWalkingRunning":
          return .distanceWalkingRunning
        case "stepCount":
          return .stepCount
        case "heartRate":
          return .heartRate
        default:
          return .stepCount
      }
    }

}

