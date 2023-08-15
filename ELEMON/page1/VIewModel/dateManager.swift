//
//  dateManager.swift
//  ELEMON
//
//  Created by 中島瑠斗 on 2023/08/07.
//

import Foundation

//data関連
class dateManager: ObservableObject{
    @Published var dateItem: [String] = []
    
    init() {
        for i in (0..<7).reversed() {
            let days = Calendar.current.date(byAdding: .day,value: -i, to: Date())!
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd"
            let dateStr = formatter.string(from: days as Date)
            formatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale?
            
            dateItem.append(dateStr)
            
        }
    }
}
