//
//  GoalViewModel.swift
//  U22Prot0601
//
//  Created by 中島瑠斗 on 2023/06/14.
//

import Foundation
import SwiftUI

class GoalViewModel: ObservableObject{
    
    @AppStorage("goalTitle") var goalTitle = ""
    @AppStorage("goalNumber") var goalNumber = 0
}
