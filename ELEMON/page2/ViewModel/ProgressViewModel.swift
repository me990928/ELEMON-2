//
//  ProgressViewModel.swift
//  U22Prot0601
//
//  Created by 中島瑠斗 on 2023/06/14.
//

import Foundation
import SwiftUI

class ProgressViewModel: ObservableObject{
    
    @AppStorage("goalString") var goalString = ""
    @AppStorage("goalValue") var goalValue = 1
    
    @Published var dateItem: [String] = []
    @Published var progress: [Progress] = []
    @Published var value = 0
    @Published var date = ""
    @Published var nowValue = 0
    
    init() {
        fetchProgress()
        for i in (0..<7).reversed() {
            let days = Calendar.current.date(byAdding: .day,value: -i, to: Date())!
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd"
            let dateStr = formatter.string(from: days as Date)
            formatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale?
            
            dateItem.append(dateStr)
            
        }
        //print(dateItem)
    }
    
//    func tameshi() {
//        Progress.tameshi()
//    }
    
    func todayItem() -> Int {
        if let todayItem = progress.first(where: { $0.date == getCurrentDate()}) {
            let value = todayItem.value
            return value
        } else { return 0 }
        
    }
    
    func fetchProgress() {
        self.progress = Progress.fetchAllProgress()!
        //print(self.todos)
    }
    
    func progressGudg() {
        let nowDate = getCurrentDate()
        if let Items = self.progress.first(where: { $0.date == nowDate }){
            var i = Items.value
            i += nowValue
            Progress.updateProgress(newValue: i, date: nowDate)
            self.nowValue = 0
            fetchProgress()
        } else {
            addProgress(date: nowDate)
            self.nowValue = 0
            print(nowValue)
        }
        return
    }
    
    func addProgress(date: String) {
        Progress.addProgress(value: self.nowValue, date: date)
        fetchProgress()
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
    
    static let shared = ProgressViewModel() // シングルトンとする
    
}
