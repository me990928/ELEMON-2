//
//  HeartViewModel.swift
//  HealthItem
//
//  Created by 中島瑠斗 on 2023/06/28.
//

import SwiftUI
import Combine
import HealthKit
 
class HeartViewModel: ObservableObject, Identifiable {
 
    @Published var dataSource:[HeartItem] = []
    
    func get( fromDate: Date, toDate: Date)  {
 
        let healthStore = HKHealthStore()
        let readTypes = Set([
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate )!
        ])
        
        healthStore.requestAuthorization(toShare: [], read: readTypes, completion: { success, error in
            
            if success == false {
                print("データにアクセスできません")
                return
            }
            
            // 心拍数を取得
            let query = HKSampleQuery(sampleType: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!,
                                           predicate: HKQuery.predicateForSamples(withStart: fromDate, end: toDate, options: []),
                                           limit: HKObjectQueryNoLimit,
                                           sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)]){ (query, results, error) in
                
                guard error == nil else { print("error"); return }
                
                if let tmpResults = results as? [HKQuantitySample] {
                    
                    // 取得したデータを１件ずつ ListRowItem 構造体に格納
                    // ListRowItemは、dataSource配列に追加します。ViewのListでは、この dataSource配列を参照して心拍数を表示します。
                    for item in tmpResults {
 
                        let listItem = HeartItem(
                            id: item.uuid.uuidString,
                            datetime: item.endDate,
                            count: String(item.quantity.doubleValue(for: HKUnit(from: "count/min")))
                        )
 
                        self.dataSource.append(listItem)
                    }
                }
            }
            healthStore.execute(query)
        })
    }
}
