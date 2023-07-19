//
//  Health.swift
//  HealthItem
//
//  Created by 中島瑠斗 on 2023/06/28.
//

import Foundation

struct Health: Identifiable, Hashable {
  var id: String
  var name: String
  var image: String
}

var allActivities: [Health] = [
  Health(id: "activeEnergyBurned", name: "Active Burned Calories", image: "⚡️"),
  Health(id: "appleExerciseTime", name: "Exercise Time", image: "🏋🏻‍♂️"),
  Health(id: "appleStandTime", name: "Stand Time", image: "🧍‍♂️"),
  Health(id: "distanceWalkingRunning", name: "Distance Walking/Running", image: "🏃‍♂️"),
  Health(id: "stepCount", name: "Step Count", image: "👣"),
  Health(id: "heartRate", name: "Heart Rate", image: "H")

]
