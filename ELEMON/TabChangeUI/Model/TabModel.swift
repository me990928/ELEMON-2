//
//  TabModel.swift
//  TabChangeUI
//
//  Created by Yuya Hirose on 2023/07/05.
//

import Foundation

class TabModel:ObservableObject {
    @Published var xOfset:Bool = false
    @Published var xOfsetVal:CGFloat = 0
    @Published var xOfsetSt:CGFloat = 0
}
