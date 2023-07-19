//
//  ProgressViewModel.swift
//  U22Prot0601
//
//  Created by 中島瑠斗 on 2023/06/14.
//

import Foundation
import SwiftUI

class ProgressViewModel: ObservableObject{
    
    @AppStorage("goalString") var goalString = ""
    @AppStorage("nowValue") var nowValue = 0
    @AppStorage("goalValue") var goalValue = 0
    
}
