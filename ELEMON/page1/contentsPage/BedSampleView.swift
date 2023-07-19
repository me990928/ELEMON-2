//
//  MindFullnessSampleView.swift
//  page1
//
//  Created by 広瀬友哉 on 2023/05/15.
//

import SwiftUI

struct BedSampleView: View{

    @EnvironmentObject var healthSleep: HealthSleep
    @ObservedObject var model = ActivityModel()
    
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "bed.double").font(.title).padding().foregroundColor(.primary)
                Text("睡眠")
                    .font(.title).foregroundColor(.primary)
                Spacer()
            }
            
            GroupBox{
                VStack{
                    HStack {
                        Text("今日の睡眠時間").font(.title2).foregroundColor(.primary)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        if let lastSleep = healthSleep.sleepTime.last {
                            Text(lastSleep.value)
                                .font(.largeTitle)
                                .foregroundColor(.primary)
                                .padding(.horizontal, 10)
                                .onAppear {
                                    model.sleepTime = lastSleep.value
                                }
                        }

                    }
                    
                    
                }
            }.padding()
            
            GroupBox {
                VStack{
                    HStack {
                        Text("今週の睡眠時間").font(.title2).foregroundColor(.primary)
                        Spacer()
                    }
                    SleepChartView(sleepTime: healthSleep.sleepTime).frame(height: 200).padding()
                }
            }.padding()
            Spacer()
        }
    }
}

struct BedSampleView_Previews: PreviewProvider {
    static var previews: some View {
        BedSampleView().environmentObject(HealthSleep())
    }
}
