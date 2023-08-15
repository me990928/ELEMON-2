//
//  ProgressGraf.swift
//  U22Prot0601
//
//  Created by 中島瑠斗 on 2023/06/14.
//

import SwiftUI
import Charts


struct ProgressGraf: View {
    @ObservedObject var progressModel = ProgressViewModel()
    
    
    var body: some View {
        
        VStack{
            Chart{
                ForEach(progressModel.dateItem,id: \.self){ items in
                    if let item = progressModel.progress.first(where: { $0.date == items}) {
                        let itemValue = item.value
                        BarMark(
                            x: .value("date", items),
                            y: .value("value", itemValue)
                        ).foregroundStyle(Color.blue)
                    } else {
                        BarMark(
                            x: .value("date", items),
                            y: .value("value", 0)
                        ).foregroundStyle(Color.blue)
                    }
                }
                
            }
           
        }
    }
}

struct grafView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressGraf()
    }
}

