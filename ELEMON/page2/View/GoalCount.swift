//
//  GoalCount.swift
//  U22Prot0601
//
//  Created by 中島瑠斗 on 2023/06/13.
//

import SwiftUI
import UIKit

struct GoalCount: View {
    
    @ObservedObject var viewModel = GoalViewModel()
    
    var toDate = Calendar.current.date(byAdding:.day,value:1,to:Date())
    
    var body: some View {
        //TimerView(setDate: toDate!)
        VStack{
            
            HStack{
                Spacer()
                Text("\(viewModel.goalTitle)")
                    .font(.title)
                Text("まで")
                    .padding(.top, 8.0)
                Spacer()
            }
            HStack{
                Text("あと")
                    .padding(.top, 8.0)
                Text("\(viewModel.goalNumber)日").font(.largeTitle)
            }//hstack
        }//vsta
    }
}

struct GoalCount_Previews: PreviewProvider {
    static var previews: some View {
        GoalCount()
    }
}
