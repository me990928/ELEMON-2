//
//  MindFullnessSampleView.swift
//  page1
//
//  Created by 広瀬友哉 on 2023/05/15.
//

import SwiftUI

struct MindFullnessSampleView: View {
    
    @EnvironmentObject var healthSleep: HealthSleep
    @ObservedObject var model = ActivityModel()
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "figure.walk").font(.title).padding().foregroundColor(.primary)
                Text("マインドフルネス")
                    .font(.title).foregroundColor(.primary)
                Spacer()
            }
            
            GroupBox{
                VStack{
                    HStack {
                        Text("今日のマインドフルネス").font(.title2).foregroundColor(.primary)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        if let lastMindTime = healthSleep.MindTime.last {
                            Text(lastMindTime.value)
                                .font(.largeTitle)
                                .foregroundColor(.primary)
                                .padding(.horizontal, 10)
                                .onAppear {
                                    model.mindTime = lastMindTime.value
                                    
                                }
                    
                        }
                    }
                }
            }.padding()
            
            GroupBox {
                VStack{
                    HStack {
                        Text("今週のマインドフルネス").font(.title2).foregroundColor(.primary)
                        Spacer()
                    }
                    SleepChartView(sleepTime: healthSleep.MindTime).frame(height: 200).padding()
                }
            }.padding()
            Spacer()
        }
    }
}

struct MindFullnessSampleView_Previews: PreviewProvider {
    static var previews: some View {
        MindFullnessSampleView().environmentObject(HealthSleep())
    }
}
