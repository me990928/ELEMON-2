//
//  MindFullnessSampleView.swift
//  page1
//
//  Created by 広瀬友哉 on 2023/05/15.
//

import SwiftUI

struct BedSampleView: View{
    
    @EnvironmentObject var healthSleep: HealthSleep
    @ObservedObject var model = ActivityModel()
    
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "bed.double").font(.title).padding().foregroundColor(.primary)
                Text("睡眠")
                    .font(.title).foregroundColor(.primary)
                Spacer()
            }
            
            GroupBox{
                VStack{
                    HStack {
                        Text("今日の睡眠時間").font(.title2).foregroundColor(.primary)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        let nowDate = getCurrentDate()
                        if let lastSleep = healthSleep.sleepTime.first(where: { $0.date == nowDate }){
                            Text(lastSleep.value)
                                .font(.largeTitle)
                                .foregroundColor(.primary)
                                .padding(.horizontal, 10)
                                .onAppear {
                                    model.sleepTime = lastSleep.value
                                }
                        } else {
                            Text("0時間00分")
                                .font(.largeTitle)
                                .foregroundColor(.primary)
                                .padding(.horizontal, 10)
                                .onAppear {
                                    model.sleepTime = "0時間00分"
                                }
                        }
                        
                    }
                }
            }.padding()
            
            GroupBox {
                VStack{
                    HStack {
                        Text("今週の睡眠時間").font(.title2).foregroundColor(.primary)
                        Spacer()
                    }
                    SleepChartView(sleepTime: healthSleep.sleepTime).frame(height: 200).padding()
                }
            }.padding()
            Spacer()
        }.onAppear{
            healthSleep.getHealthKitData()
        }
    }
    func getCurrentDate() -> String {
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        let dateStr = formatter.string(from: date as Date)
        formatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale?
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EEEEE", options: 0, locale: Locale.current)
        //let weekStr = formatter.string(from: date as Date)
        //return  dateStr + " (" + weekStr + ")"
        return dateStr//00/00を返す
    }
}

struct BedSampleView_Previews: PreviewProvider {
    static var previews: some View {
        BedSampleView().environmentObject(HealthSleep())
    }
}
