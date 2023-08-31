//
//  ELEMONApp.swift
//  ELEMON
//
//  Created by Yuya Hirose on 2023/07/19.
//

import SwiftUI
import FirebaseCore

@main
struct ELEMONApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            TabChangeUI().environmentObject(FireAuthModel()).environmentObject(HealthSleep()).environmentObject(TabModel()).environmentObject(ColorThema()).environmentObject(ViewState())
        }
    }
}
