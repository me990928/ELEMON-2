//
//  HealthSleep.swift
//  HealthItem
//
//  Created by 中島瑠斗 on 2023/06/28.
//

import Foundation
import HealthKit


struct SleepData:Identifiable {
    var id: String
    var startDate: Date
    var endDate: Date
    var status: Int
}

class HealthSleep: ObservableObject{

    
    //healthKitのデータへのアクセスポイント
    let healthStore = HKHealthStore()

    @Published var sleepTime:[SleepGraf] = []
    @Published var MindTime:[SleepGraf] = []
    
    
    var sleepData:[SleepData] = []

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

                    var i = 6
                    var n = 6
                    
                    self.fetchSleepTime(){ sleepTime in
                        
                        DispatchQueue.main.async {
                            let sleepTimeString = sleepTime.map { self.timeString(from: $0) } ?? "0時間00分"
                            let days = Calendar.current.date(byAdding: .day,value: -i, to: Date())!
                            let formatter = DateFormatter()
                            formatter.dateFormat = "MM/dd"
                            let dateStr = formatter.string(from: days as Date)
                            formatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale?
                            
                            let item = SleepGraf(value: sleepTimeString,date: dateStr)
                            self.sleepTime.append(item)
                            //print(self.sleepTime)
                            //print(i)
                            i -= 1
                            
                        }
                        print(success)
                    }
                    //sleepおわり
                    
                    self.fetchMind(){ mindTime in
                        DispatchQueue.main.async {
                            let sleepTimeString = mindTime.map { self.timeString(from: $0) } ?? "0時間00分"
                            let days = Calendar.current.date(byAdding: .day,value: -n, to: Date())!
                            let formatter = DateFormatter()
                            formatter.dateFormat = "MM/dd"
                            let dateStr = formatter.string(from: days as Date)
                            formatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale?
                            
                            let item = SleepGraf(value: sleepTimeString,date: dateStr)
                            self.MindTime.append(item)
                            
                            n -= 1
                            
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
    func fetchSleepTime(completion: @escaping (Double?) -> Void){
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
                
//                let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
                
                let calendar = Calendar.current
                let startDate = calendar.startOfDay(for: Date())
                let endDate = calendar.date(byAdding: .day, value: -6, to: startDate)!

                let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
                       
                
                let query = HKSampleQuery(sampleType: sleepType, predicate: HKQuery.predicateForSamples(withStart: Calendar.current.date(byAdding: .month, value: -1, to: Date())!, end: Date(), options: []), limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
                    guard let samples = samples as? [HKCategorySample], error == nil else {
                        completion(nil)
                        return
                    }
                    
                    
                    for i in samples {
//                        print("状態：\(i.value)")
                        print("開始：\(i.startDate)")
                        print("終了：\(i.endDate)")
                        
                        self.sleepData.append(SleepData(id: UUID().uuidString ,startDate: i.startDate, endDate: i.endDate, status: i.value))
                        
                    }
                    
                    for i in self.sleepData {
                        print(i.startDate)
                    }
                    
                    var totalTimeAsleep = 0.0
                    
                    for sample in samples {
                        let startSleep = sample.startDate
                        let endSleep = sample.endDate
                        let duration = endSleep.timeIntervalSince(startSleep)
                        
                        totalTimeAsleep += duration
                    }
                    completion(totalTimeAsleep)
                }
                self.healthStore.execute(query)
            }
            
        }
        
    }

    //マインドフルネスを取得
    func fetchMind(completion: @escaping (Double?) -> Void){
        guard let mindType = HKCategoryType.categoryType(forIdentifier: .mindfulSession) else {
            completion(nil)
            return
        }
        healthStore.requestAuthorization(toShare: nil, read: [mindType]) { (success, error) in
            guard success else {
                completion(nil)
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
                        completion(nil)
                        return
                    }
                    
                    var totalMind = 0.0
                    
                    for sample in samples {
                        let startDate = sample.startDate
                        let endDate = sample.endDate
                        let duration = endDate.timeIntervalSince(startDate)
                        
                        totalMind += duration
                    }
                    completion(totalMind)
                }
                self.healthStore.execute(query)
            }
            
        }
        
    }

}

