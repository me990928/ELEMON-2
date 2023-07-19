//
//  goalGraf.swift
//  U22Prot0601
//
//  Created by 中島瑠斗 on 2023/06/14.
//

import Foundation
import Charts
import SwiftUI

struct progressCharts: Identifiable {
    var title: String
    var value: Double
    var color: Color = .green
    var id: String {
        return title + String(value)
    }
    
}
