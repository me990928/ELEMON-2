//
//  MindFullNess.swift
//  page1
//
//  Created by 広瀬友哉 on 2023/05/15.
//

import SwiftUI
import Charts

struct MindFullNess: View {
    
    var body: some View {
        
        
        let records: [Record] = [
            Record(week: "Mon", count: 1),
            Record(week: "Tus", count: 2),
            Record(week: "Wed", count: 3),
            Record(week: "Thr", count: 4),
            Record(week: "Fri", count: 5),
            Record(week: "Sat", count: 2),
            Record(week: "Sun", count: 1)
        ]
            VStack{
                Chart(records){
                    LineMark(
                        x: .value("Date", $0.week),
                        y: .value("Count", $0.count)
                    )
                }.foregroundColor(.blue)
            }
            
        }
    }


struct MindFullNess_Previews: PreviewProvider {
    static var previews: some View {
        MindFullNess()
    }
}
