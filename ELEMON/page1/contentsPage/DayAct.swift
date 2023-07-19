//
//  GrafY.swift
//  page1
//
//  Created by 広瀬友哉 on 2023/05/11.
//

import SwiftUI

struct CircularProgressView: View {
    var goalValue: Int
    var nowValue: Int
    let ColorStartGradient: Color
    let ColorEndGradient: Color
    
    var body: some View {
        let progress = Double(nowValue)/Double(goalValue)
        let progressText = String(format: "%.0f%%", progress * 100)
        let ColorGradient = AngularGradient(
            gradient: Gradient(colors: [
                ColorStartGradient,
                ColorEndGradient
                
                
                //ここのコメントアウトをなくして、上をコメントアウトしてください
                
                //Color("\(colorStart)"),
                //Color("\(colorEnd)")
            ]),
            center: .center,
            startAngle: .degrees(0),
            endAngle: .degrees(360.0 * progress))
        
        ZStack {
            Circle()
                .stroke(Color(.systemGray4), lineWidth: 20)
            Circle()
                .trim(from: 0, to: min(CGFloat(progress),1.0))
                .stroke(
                    ColorGradient,
                    style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .rotationEffect(Angle(degrees: -90))
                .overlay(
                    Text(progressText)
                        .font(.system(size: 20, weight: .bold, design:.rounded))
                        .foregroundColor(Color(.systemGray))
                )
        }
    }
}


struct DayAct: View {
    
    @ObservedObject var model = ActivityModel()
    
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
    }
    @State var goalValue1 = 30
    @State var goalValue2 = 30
    @State var goalValue3 = 6
    
    @State var nowValue1:Int = 30
    @State var nowValue2:Int = 10
    @State var nowValue3:Int = 3
    
    var body: some View {
        
        VStack{
                Divider()
                HStack{
                   let redStartGradient = Color(red: 200/255, green: 128/255, blue: 0/255)
                    let redEndGradient = Color(red: 255/255, green: 0/255, blue: 0/255)
                    CircularProgressView(goalValue: goalValue1, nowValue: nowValue1,ColorStartGradient: redStartGradient,ColorEndGradient: redEndGradient).frame(width: 100)
                    Spacer()
                    Text("ムーブ").font(.title).foregroundColor(Color(.label))
                    Spacer()
                    VStack(alignment: .trailing){
                        if let lastStat = viewModel1.stats.last {
                            let value = viewModel1.value(from: lastStat.stat).value
                            Text(viewModel1.value(from: lastStat.stat).desc+"/\(goalValue1)kcal")
                                    .foregroundColor(Color(.systemRed))
                                    .onAppear {
                                        nowValue1 = value
                                        model.nowMove = value // valueをnowValue2に格納
                                    }
                            }
                    }
                }.padding()
                Divider()
                HStack{
                    let redStartGradient = Color(red: 173/255, green: 255/255, blue: 47/255)
                     let redEndGradient = Color(red: 0/255, green: 255/255, blue: 0/255)
                     CircularProgressView(goalValue: goalValue2, nowValue: nowValue2,ColorStartGradient: redStartGradient,ColorEndGradient: redEndGradient).frame(width: 100)
                    Spacer()
                    Text("エクササイズ").font(.title).foregroundColor(Color(.label))
                    Spacer()
                    VStack(alignment: .trailing){
                        if let lastStat = viewModel2.stats.last {
                            let value = viewModel2.value(from: lastStat.stat).value
                            Text(viewModel2.value(from: lastStat.stat).desc+"/\(goalValue2)分")
                                    .foregroundColor(Color(.systemGreen))
                                    .onAppear {
                                        nowValue2 = value // valueをnowValue2に格納
                                    }
                            }
                    }
                }.padding()
                Divider()
                HStack{
                    let redStartGradient = Color(red: 0/255, green: 128/255, blue: 0/255)
                     let redEndGradient = Color(red: 0/255, green: 0/255, blue: 255/255)
                     CircularProgressView(goalValue: goalValue3, nowValue: nowValue3,ColorStartGradient: redStartGradient,ColorEndGradient: redEndGradient).frame(width: 100)
                    Spacer()
                    Text("スタンド").font(.title).foregroundColor(Color(.label))
                    Spacer()
                    VStack(alignment: .trailing){
                        if let lastStat = viewModel3.stats.last {
                            let value = viewModel3.value(from: lastStat.stat).value
                            Text(viewModel3.value(from: lastStat.stat).desc+"/\(goalValue3)時間")
                                    .foregroundColor(Color(.systemBlue))
                                    .onAppear {
                                        nowValue3 = value
                                        model.nowStand  = value // valueをnowValue2に格納
                                    }
                            }
                    }
                }.padding()
                Divider()
        }
    }
}
struct DayAct_Previews: PreviewProvider {
    static var previews: some View {
        DayAct(
            health1: Health(id: "activeEnergyBurned", name: "Active Burned Calories", image: "⚡️"),
            health2: Health(id: "appleExerciseTime", name: "Exercise Time", image: "🏋🏻‍♂️"),
            health3: Health(id: "appleStandTime", name: "Stand Time", image: "🧍‍♂️"),
            repository: HKRepository())
    }
}
