//
//  GoalView.swift
//  U22Prot0601
//
//  Created by 中島瑠斗 on 2023/06/13.
//

import SwiftUI

struct GoalView: View {

    var body: some View {
        VStack{
            Spacer().frame(height: 10)
            GoalPage()
        }
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
    }
}
