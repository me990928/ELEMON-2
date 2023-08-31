//
//  hartsSampleView.swift
//  page1
//
//  Created by 広瀬友哉 on 2023/05/09.
//

import SwiftUI
import HealthKit
import Foundation
import Charts

struct ListRowItem: Identifiable {
    var id: String
    var datetime: Date
    var count: String
}


struct HeartRateData: Identifiable {
    let id = UUID()
    var title: String
    let value: Double
}

struct HeartRateChartView: View {
    @AppStorage ("heartArr") var heartArr: String = ""

    @State var data: [HeartRateData] = [
    ]
    
    
    var body: some View {
        VStack{
            Chart(data){ point in
                BarMark(
                    x: .value("title", point.title),
                    y: .value("name", point.value)
                ).foregroundStyle(Color(.systemPink))
            }
        }.onAppear(){
//            if heartArr == "" {
//                data.append(HeartRateData(title: "non", value: 0.0))
//                print(data)
//            }
            updateData()
        }
        .onChange(of: heartArr) { newValue in
            data.append(HeartRateData(title: String(data.count), value: 0))
            updateData()
        }
    }
    
    func updateData(){
        var r = heartArr.split(separator: ",")
        data = []
        print(r)
        var c = 1
        if(r.count < 7){
            for _ in 0..<7-r.count{
                r.insert("0", at: 0)
            }
        }
        for i in 0..<r.count {
            if(Int(r.count)-(Int(r.count)-7) > i){
                data.append(HeartRateData(title: String(i + 1), value: Double(r[i]) ?? 0.0))
            }
        }
    }
}

//class HeartsStore:ObservableObject, Identifiable {
//
//    @Published var dataSource:[ListRowItem] = []
//
//    func get( fromDate: Date, toDate: Date)  {
//
//        let healthStore = HKHealthStore()
//        let readTypes = Set([
//            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate )!
//        ])
//
//        healthStore.requestAuthorization(toShare: [], read: readTypes, completion: { success, error in
//
//            if success == false {
//                print("データにアクセスできません")
//                return
//            }
//
//            // 心拍数を取得
//            let query = HKSampleQuery(sampleType: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!,
//                                           predicate: HKQuery.predicateForSamples(withStart: fromDate, end: toDate, options: []),
//                                           limit: HKObjectQueryNoLimit,
//                                           sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)]){ (query, results, error) in
//
//                guard error == nil else { print("error"); return }
//
//                if let tmpResults = results as? [HKQuantitySample] {
//
//                    // 取得したデータを１件ずつ ListRowItem 構造体に格納
//                    // ListRowItemは、dataSource配列に追加します。ViewのListでは、この dataSource配列を参照して心拍数を表示します。
//                    for item in tmpResults {
//
//                        let listItem = ListRowItem(
//                            id: item.uuid.uuidString,
//                            datetime: item.endDate,
//                            count: String(item.quantity.doubleValue(for: HKUnit(from: "count/min")))
//                        )
//
//                        self.dataSource.append(listItem)
//                    }
//                }
//            }
//            healthStore.execute(query)
//        })
//    }
//}

struct hartsSampleView: View {
//    var body: some View {
//        ScrollView{
//            VStack{
//                HStack{
//                    Image(systemName: "waveform.path.ecg").font(.title).padding(.leading).foregroundColor(.primary)
//                    Text("心拍数")
//                        .font(.title).foregroundColor(.primary)
//                    Spacer()
//                }
//
//                GroupBox{
//                    VStack{
//                        HStack {
//                            Image(systemName: "heart.fill").font(.title2).foregroundColor(.pink)
//                            Text("最近の心拍数").font(.title2).foregroundColor(.pink)
//                            Spacer()
//                            Text("11:20").font(.title2).foregroundColor(.secondary)
//                        }
//
//                        HStack {
//                            Spacer()
//                            Text("70").font(.largeTitle).padding([.top]).foregroundColor(.primary)
//                            Text("拍/分").padding(.top).foregroundColor(.secondary)
//                        }
//                    }
//                }.padding()
//                GroupBox{
//                    VStack{
//                        HStack {
//                            Image(systemName: "heart.fill").font(.title2).foregroundColor(.pink)
//                            Text("歩行時の心拍数").font(.title2).foregroundColor(.pink)
//                            Spacer()
//                            Text("11:20").font(.title2).foregroundColor(.secondary)
//                        }
//
//                        HStack {
//                            Spacer()
//                            Text("70").font(.largeTitle).padding([.top]).foregroundColor(.primary)
//                            Text("拍/分").padding(.top).foregroundColor(.secondary)
//                        }
//                    }
//                }.padding()
//                GroupBox{
//                    VStack{
//                        HStack {
//                            Image(systemName: "heart.fill").font(.title2).foregroundColor(.pink)
//                            Text("安政時の心拍数").font(.title2).foregroundColor(.pink)
//                            Spacer()
//                            Text("11:20").font(.title2).foregroundColor(.secondary)
//                        }
//
//                        HStack {
//                            Spacer()
//                            Text("70").font(.largeTitle).padding([.top]).foregroundColor(.primary)
//                            Text("拍/分").padding(.top).foregroundColor(.secondary)
//                        }
//                    }
//                }.padding()
//
//                GroupBox{
//                    VStack{
//                        HStack {
//                            Image(systemName: "heart.fill").font(.title2).foregroundColor(.pink)
//                            Text("時間ごとの心拍数").font(.title2).foregroundColor(.pink)
//                            Spacer()
//                            Text("11:20").font(.title2).foregroundColor(.secondary)
//                        }
//                        LineMarke(pointColor: "gradEndRed")
//                    }
//                }.padding()
//                Spacer()
//            }
//        }
//    }
    
    
    
    
    
    
    
    
//    @ObservedObject var contentVM:HeartsStore
//    let dateformatter = DateFormatter()
//    init(){
//
//        contentVM = HeartsStore()
//
//        dateformatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
//        dateformatter.locale = Locale(identifier: "ja_JP")
//        dateformatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
//
//        // 心拍数データを取得する関数を呼ぶ（引数は期間）
//        contentVM.get(
//            fromDate: dateformatter.date(from: "2020/12/01 00:00:00")!,
//            toDate: dateformatter.date(from: "2021/01/01 23:59:59")!
//        )
//    }
//
//    var body: some View {
//        NavigationView {
//            List {
//                if contentVM.dataSource.count == 0 {
//                    Text("データがありません。")
//                } else {
////                    ForEach( contentVM.dataSource ){ item in
////                        HStack{
////                            Text(dateformatter.string(from: item.datetime))
////                            Text(" \(item.count)")
////                        }
////                    }
//                    HStack{
//                        Text(dateformatter.string(from: contentVM.dataSource.last?.datetime ?? Date()))
//                        Text(String(contentVM.dataSource.last?.count ?? "-1"))
//                    }
//                }
//            }.navigationBarTitle(Text("心拍数一覧"), displayMode: .inline)
//        }
//    }
    
    

    @AppStorage ("heart") var heartRate: Double = 0.0
    @AppStorage ("lastDate") var lastDate: String = "2023-01-01"
    
    @AppStorage ("heartArr") var heartArr: String = ""
    
    @State var f:Bool = false
    
    let healthStore = HKHealthStore()

    var body: some View {
        ZStack{
            VStack{
                
                HStack {
                    Spacer()
                    Button {
                        fetchLatestHeartRateSample()
                        lastDate = setLastDate()
                        print(heartArr)
                    } label: {
                        Image(systemName: "goforward").font(.title)
                    }

                }.padding(.trailing)
                Spacer()
            }
            VStack {
                GroupBox{
                    HStack {
                        Text("心拍数")
                        Spacer()
                        Text(lastDate)
                    }
                    HStack {
                        Spacer()
                        Text("\(heartRate, specifier: "%.0f") bpm")
                            .font(.title)
                            .padding()
                    }
                }.padding()
                
                GroupBox{
                    HStack{Text("最近の心拍数").font(.title2); Spacer()}
                    HeartRateChartView().frame(height: 300).padding()
                }.padding()
            }
        }
    }
    
    func setLastDate() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            
            return formatter.string(from: Date())
        }

    func fetchLatestHeartRateSample() {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
            // 心拍数タイプが無効な場合の処理
            return
        }

        let query = HKSampleQuery(sampleType: heartRateType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            guard let samples = samples as? [HKQuantitySample], let lastSample = samples.last else {
                // 心拍数データが見つからない場合の処理
                return
            }

            let heartRateUnit = HKUnit.count().unitDivided(by: .minute())
            let heartRate = lastSample.quantity.doubleValue(for: heartRateUnit)

            // 心拍数を更新する
            DispatchQueue.main.async {
                self.heartRate = heartRate
                self.heartArr += "\(heartRate),"
            }
        }

        healthStore.execute(query)
    }
}

struct hartsSampleView_Previews: PreviewProvider {
    static var previews: some View {
        hartsSampleView().environmentObject(FireAuthModel()).environmentObject(HealthSleep()).environmentObject(TabModel())
    }
}
