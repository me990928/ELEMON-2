//
//  graf.swift
//  page1
//
//  Created by 広瀬友哉 on 2023/05/08.
//

import Foundation
import Charts
import SwiftUI

struct charts: Identifiable {
    var title: String
    var value: Double
    var color: Color = .green
    var id: String {
        return title + String(value)
    }
}

struct datever: Identifiable {
    var id:UUID = UUID()
    var value: Double
    let date: Date
}

struct Record: Identifiable {
    var id: UUID = UUID()
    let week: String
    let count: Int
}
