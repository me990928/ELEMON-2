//
//  HealthSleep.swift
//  HealthItem
//
//  Created by 中島瑠斗 on 2023/06/28.
//

import Foundation
import HealthKit

class HealthSleep: ObservableObject{
    
    //healthKitのデータへのアクセスポイント
    let healthStore = HKHealthStore()

    @Published var sleepTime:[SleepGraf] = []
    @Published var MindTime:[SleepGraf] = []

    //データの読み取り、書き込みを許可するかどうかの確認
    func getHealthKitData() {
        let typesToRead = Set([
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!,
            HKQuantityType.quantityType(forIdentifier: .height)!,
            HKObjectType.quantityType(forIdentifier: .bodyMass)!,
            HKObjectType.quantityType(forIdentifier: .bodyMassIndex)!,
            HKCategoryType.categoryType(forIdentifier: .mindfulSession)!,
            
        ])
        let typesToShare = Set([
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!,
            HKQuantityType.quantityType(forIdentifier: .height)!,
            HKObjectType.quantityType(forIdentifier: .bodyMass)!,
            HKObjectType.quantityType(forIdentifier: .bodyMassIndex)!,
        ])
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
            if success {
                DispatchQueue.main.async {

                    self.fetchSleepTime(){ sleepTime,sleepDate in
                        
                        DispatchQueue.main.async {
                            //print("\(sleepTime)")
                            let sleepTimeString = sleepTime.map { self.timeString(from: $0) } ?? "0時間00分"
                            let sleepDateString = sleepDate ?? ""

                            
                            let item = SleepGraf(value: sleepTimeString,date: sleepDateString)
                            self.sleepTime.append(item)
                            //print(self.sleepTime)
                            //print(i)

                            
                        }
                        //print(self.sleepTime)
                    }
                    //sleepおわり
                    
                    self.fetchMind(){ mindTime,mindDate in
                        DispatchQueue.main.async {
                            let sleepTimeString = mindTime.map { self.timeString(from: $0) } ?? "0時間00分"
                            let mindDateString = mindDate ?? ""
                            
                            let item = SleepGraf(value: sleepTimeString,date: mindDateString)
                            self.MindTime.append(item)
                            
                        }
                        //print(self.MindTime)
                    }

            
                    
                }
            } else {
                print("Authorization failed")
                if let error = error {
                    print("\(error.localizedDescription)")
                }
            }
        }
    }
    
    //時間に関するもの
    func timeString(from seconds: Double) -> String {
        let totalSeconds = Int(seconds)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        return String(format: hours >= 10 ? "%02d時間%02d分" : "%2d時間%02d分" , hours, minutes)
    }
    private func get24hPredicate() ->  NSPredicate{
        let today = Date()
        let startDate = Calendar.current.date(byAdding: .hour, value: -24, to: today)
        let predicate = HKQuery.predicateForSamples(withStart: startDate,end: today,options: [])
        return predicate
    }
    //sleep日毎集計
    /*func fetchSleepTime(completion: @escaping (Double?) -> Void){
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            completion(nil)
            return
        }
        healthStore.requestAuthorization(toShare: nil, read: [sleepType]) { (success, error) in
            guard success else {
                completion(nil)
                return
            }
            let calendar = Calendar.current
            let endDate = Date()
            for i in (0..<7).reversed(){
               // print(i)
                //hour 15 で日本時間の0:00分に戻してる。
                let agoDay = calendar.date(byAdding: DateComponents(day: -i, hour: 15), to: endDate)!
                let start = calendar.startOfDay(for: agoDay)
                let startOfDay = calendar.date(byAdding: .hour, value: -3, to: start)!
                
                let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
                
                let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
                
                let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
                    guard let samples = samples as? [HKCategorySample], error == nil else {
                        completion(nil)
                        return
                    }
                    
                    var totalTimeAsleep = 0.0
                    var formattedDate = ""
                    
                    for sample in samples {
                        
                        let startSleep = sample.startDate
                        let endSleep = sample.endDate
                        let duration = endSleep.timeIntervalSince(startSleep)
//                        print("*******************************************:")
//                        print(endSleep)
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MM/dd"
                        formattedDate = dateFormatter.string(from: endSleep)
//                        print("+++++++++++++++++++++++++++++++++++++++++++++++")
//                        print(formattedDate)
                        
                        totalTimeAsleep += duration
                        
                    }
                    completion(totalTimeAsleep)
                }
//                print("+++++++++++++++++++++++++++++++++++++++++++++++")
//                print(query)
                self.healthStore.execute(query)
            }
            
        }
        
    }*/

    func fetchSleepTime(completion: @escaping (Double?,String?) -> Void){
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            completion(nil,nil)
            return
        }
        healthStore.requestAuthorization(toShare: nil, read: [sleepType]) { (success, error) in
            guard success else {
                completion(nil,nil)
                return
            }
            let calendar = Calendar.current
            let endDate = Date()
            for i in (0..<7).reversed(){
               // print(i)
                //hour 15 で日本時間の0:00分に戻してる。
                let agoDay = calendar.date(byAdding: DateComponents(day: -i, hour: 15), to: endDate)!
                let start = calendar.startOfDay(for: agoDay)
                let startOfDay = calendar.date(byAdding: .hour, value: -3, to: start)!
                
                let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
                
                let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
                
                let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
                    guard let samples = samples as? [HKCategorySample], error == nil else {
                        completion(nil,nil)
                        return
                    }
                    
                    var totalTimeAsleep = 0.0
                    var formattedDate = ""
                    
                    for sample in samples {
                        
                        let startSleep = sample.startDate
                        let endSleep = sample.endDate
                        let duration = endSleep.timeIntervalSince(startSleep)
//                        print("*******************************************:")
//                        print(endSleep)
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MM/dd"
                        formattedDate = dateFormatter.string(from: endSleep)
//                        print("+++++++++++++++++++++++++++++++++++++++++++++++")
//                        print(formattedDate)
                        
                        totalTimeAsleep += duration
                        
                    }
                    completion(totalTimeAsleep,formattedDate)
                }
//                print("+++++++++++++++++++++++++++++++++++++++++++++++")
//                print(query)
                self.healthStore.execute(query)
            }
            
        }
        
    }
    
    //マインドフルネスを取得
    func fetchMind(completion: @escaping (Double?,String?) -> Void){
        guard let mindType = HKCategoryType.categoryType(forIdentifier: .mindfulSession) else {
            completion(nil,nil)
            return
        }
        healthStore.requestAuthorization(toShare: nil, read: [mindType]) { (success, error) in
            guard success else {
                completion(nil,nil)
                return
            }
            let calendar = Calendar.current
            let endDate = Date()
            for i in (0..<7).reversed(){
                //hour 15 で日本時間の0:00分に戻してる。
                let agoDay = calendar.date(byAdding: DateComponents(day: -i, hour: 15), to: endDate)!
                let startOfDay = calendar.startOfDay(for: agoDay)
                
                let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
                
                let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
                
                let query = HKSampleQuery(sampleType: mindType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
                    guard let samples = samples as? [HKCategorySample], error == nil else {
                        completion(nil,nil)
                        return
                    }
                    
                    var totalMind = 0.0
                    var formattedDate = ""
                    
                    for sample in samples {
                        let startDate = sample.startDate
                        let endDate = sample.endDate
                        let duration = endDate.timeIntervalSince(startDate)
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MM/dd"
                        formattedDate = dateFormatter.string(from: endDate)
                        
                        totalMind += duration
                    }
                    completion(totalMind,formattedDate)
                }
                self.healthStore.execute(query)
            }
            
        }
        
    }

}

