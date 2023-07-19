//
//  ActivityMoel.swift
//  HealthItem
//
//  Created by 中島瑠斗 on 2023/06/28.
//

import Foundation
import SwiftUI

class ActivityModel: ObservableObject{
    @AppStorage("goalString") var goalString = ""
    @AppStorage("sleep") var sleepTime = "0時間0分"
    @AppStorage("mind") var mindTime = "0時間0分"
    @AppStorage("step") var stepCount = "0"
    @AppStorage("weight") var weight = 50.0
    @AppStorage("height") var height = 160.0
    @AppStorage("Bmi") var bmi = 19.53124
    
    @AppStorage("nowWater") var nowWater = 0
    @AppStorage("goalWater") var goalWater = 2000
    @AppStorage("waterString") var goalWaterString = ""
    
    @AppStorage("nowCal") var nowCal = 0
    @AppStorage("goalCal") var goalCal = 1200
    @AppStorage("calString") var goalCalString = ""
    
    @AppStorage("nowMove") var nowMove = 0
    @AppStorage("nowStand") var nowStand = 0
    
    @Published var nowValue = 0
    @Published var goalValue = 30
    @Published var activity = 30
    
}
