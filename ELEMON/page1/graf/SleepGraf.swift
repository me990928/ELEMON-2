//
//  SleepGraf.swift
//  HealthItem
//
//  Created by 中島瑠斗 on 2023/07/03.
//

import Foundation
import SwiftUI

struct SleepGraf: Identifiable {
    let value: String
    let date: String
    
    var id: String { date }
    
    init( value:String ,date:String) {
        self.value = value
        self.date = date
    }
}
