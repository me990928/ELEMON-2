//
//  Detail.swift
//  HealthItem
//
//  Created by 中島瑠斗 on 2023/06/28.
//

import SwiftUI


struct WalkDetailView: View {
    var health: Health
    var repository: HKRepository
    @ObservedObject var viewModel: HealthViewModel
    @ObservedObject var model = ActivityModel()
    
    @State var sheet:Bool = false
    
    init(health: Health, repository: HKRepository) {
        self.health = health
        self.repository = repository
        
        viewModel = HealthViewModel(health: health, repository: repository)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image(systemName: "figure.walk").font(.title).padding().foregroundColor(.primary)
                Text("歩数")
                    .font(.title).foregroundColor(.primary)
                Spacer()
            }
            GroupBox{
                VStack{
                    HStack {
                        Text("今日の歩数").font(.title2).foregroundColor(.primary)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        if let lastStat = viewModel.stats.last {
                            Text(viewModel.value(from: lastStat.stat).desc)
                                    .font(.largeTitle)
                                    .foregroundColor(.primary)
                                    .padding(.horizontal, 10)
                                    .onAppear {
                                        model.stepCount = String(viewModel.value(from: lastStat.stat).desc)
                                        
                                    }
                            }
                        
                    }
                }
            }.padding()
            
            GroupBox {
                VStack{
                    HStack {
                        Text("今週の歩数").font(.title2).foregroundColor(.primary)
                        Spacer()
                    }
                    ChartView(stats: viewModel.stats, health: health, color: Color.pink, viewModel: viewModel)
                        .padding(.bottom, 20)
                        .padding(.top, 20)
                        .frame(height: 300)
                        .padding()
                }
            }.padding()
            
            
            //これをグラフ押したら表示のところで見せるのもあり
//            List {
//                ForEach(viewModel.stats) { stat in
//                    VStack(alignment: .leading) {
//                        Text(viewModel.value(from: stat.stat).desc)
//                        Text(stat.date, style: .date).opacity(0.5)
//                    }
//                }
//            }
        }
    }
}

struct WalkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WalkDetailView(
            health: Health(id: "steps", name: "Steps", image: "👣"),
            repository: HKRepository())
    }
}
