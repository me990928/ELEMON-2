//
//  MindFullnessSampleView.swift
//  page1
//
//  Created by 広瀬友哉 on 2023/05/15.
//

import SwiftUI

struct MindFullnessSampleView: View {
    
    @EnvironmentObject var healthSleep: HealthSleep
    @ObservedObject var model = ActivityModel()
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "figure.walk").font(.title).padding().foregroundColor(.primary)
                Text("マインドフルネス")
                    .font(.title).foregroundColor(.primary)
                Spacer()
            }
            
            GroupBox{
                VStack{
                    HStack {
                        Text("今日のマインドフルネス").font(.title2).foregroundColor(.primary)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        let nowDate = getCurrentDate()
                        if let lastMindTime = healthSleep.MindTime.first(where: { $0.date == nowDate }){
                            Text(lastMindTime.value)
                                .font(.largeTitle)
                                .foregroundColor(.primary)
                                .padding(.horizontal, 10)
                                .onAppear {
                                    model.mindTime = lastMindTime.value
                                }
                        } else {
                            Text("0時間00分")
                                .font(.largeTitle)
                                .foregroundColor(.primary)
                                .padding(.horizontal, 10)
                                .onAppear {
                                    model.mindTime = "0時間00分"
                                }
                    
                        }
                    }
                }
            }.padding()
            
            GroupBox {
                VStack{
                    HStack {
                        Text("今週のマインドフルネス").font(.title2).foregroundColor(.primary)
                        Spacer()
                    }
                    SleepChartView(sleepTime: healthSleep.MindTime).frame(height: 200).padding()
                }
            }.padding()
            Spacer()
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

struct MindFullnessSampleView_Previews: PreviewProvider {
    static var previews: some View {
        MindFullnessSampleView().environmentObject(HealthSleep())
    }
}
