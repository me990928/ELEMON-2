//
//  activitySampleView.swift
//  page1
//
//  Created by 広瀬友哉 on 2023/05/11.
//

import SwiftUI

struct activitySampleView: View {
    
    private var repository = HKRepository()
    private var health1 = Health(id: "activeEnergyBurned", name: "Active Burned Calories", image: "⚡️")
    private var health2 = Health(id: "appleExerciseTime", name: "Exercise Time", image: "🏋🏻‍♂️")
    private var health3 = Health(id: "appleStandTime", name: "Stand Time", image: "🧍‍♂️")
    
    var items: [GridItem] {
      Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    }
    
    @State var selector = 0
    var body: some View {
        VStack{
            Picker("画面切り替え", selection: $selector) {
                Text("日").tag(0)
                Text("週").tag(1)
                Text("月").tag(2)
            }.pickerStyle(.segmented).padding()
            if selector == 0 {
                DayAct(health1: health1,health2: health2,health3: health3, repository: repository)
            }
            if selector == 1 {
                WeekAct(health1: health1,health2: health2,health3: health3, repository: repository)
            }
            if selector == 2 {
                MonthAct(health1: health1,health2: health2,health3: health3, repository: repository)
            }
            Spacer()
        }
    }
}

struct activitySampleView_Previews: PreviewProvider {
    static var previews: some View {
        activitySampleView()
    }
}
