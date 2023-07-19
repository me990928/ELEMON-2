//
//  WeekAct.swift
//  page1
//
//  Created by 広瀬友哉 on 2023/05/15.
//

import SwiftUI

struct MonthAct: View {
    
    
    var health1: Health
    var health2: Health
    var health3: Health
    var repository: HKRepository
    @ObservedObject var viewModel1: HealthViewModel
    @ObservedObject var viewModel2: HealthViewModel
    @ObservedObject var viewModel3: HealthViewModel
    
    init(health1: Health,health2: Health,health3:Health, repository: HKRepository) {
        self.health1 = health1
        self.health2 = health2
        self.health3 = health3
        self.repository = repository
        
        viewModel1 = HealthViewModel(health: health1, repository: repository)
        viewModel2 = HealthViewModel(health: health2, repository: repository)
        viewModel3 = HealthViewModel(health: health3, repository: repository)
        
        viewModel1.updateStats()
        viewModel2.updateStats()
        viewModel3.updateStats()
    }
    
    var body: some View {
        ScrollView{
            VStack{
                GroupBox{
                    VStack(alignment: .leading){
                        ChartView(stats: viewModel1.stats, health: health1, color: Color.red, viewModel: viewModel1)
                    }.frame(height: 200).padding()
                }.padding(.bottom)
                
                GroupBox{
                    VStack(alignment: .leading){
                        ChartView(stats: viewModel2.stats, health: health2, color: Color.green, viewModel: viewModel2)
                    }.frame(height: 200).padding()
                }.padding(.bottom)
                
                GroupBox{
                    VStack(alignment: .leading){
                        ChartView(stats: viewModel3.stats, health: health3, color: Color.blue, viewModel: viewModel3)
                    }.frame(height: 200).padding()
                }.padding(.bottom)
            }
        }
    }
}
struct MonsAct: PreviewProvider {
    static var previews: some View {
        MonthAct(
            health1: Health(id: "activeEnergyBurned", name: "Active Burned Calories", image: "⚡️"),
            health2: Health(id: "appleExerciseTime", name: "Exercise Time", image: "🏋🏻‍♂️"),
            health3: Health(id: "appleStandTime", name: "Stand Time", image: "🧍‍♂️"),
            repository: HKRepository())
    }
}
