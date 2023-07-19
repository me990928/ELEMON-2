//
//  ContentView.swift
//  page1
//
//  Created by 広瀬友哉 on 2023/05/08.
//

import SwiftUI
import UIKit
import HealthKit

struct Page1View: View {
    
    private var repository = HKRepository()
    @EnvironmentObject var healthSleep: HealthSleep
    
    @State var check = true
    
    // ire
    @State var status: HKAuthorizationStatus = .notDetermined
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color(.gray))
    }
    
    @ObservedObject var page1Model = Page1ViewModel()
    
    var columns = [GridItem(.fixed(150)),GridItem(.fixed(150))]
    var title = ["要素","要素","要素"]
    var img = ["xmark.bin","xmark.bin","xmark.bin"]
    
    @State var isPresented = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                MainSelect(page1Model: page1Model)
            }
        }.foregroundColor(.white)
            .onAppear {
              repository.requestAuthorization { status in
                print("Auth success: \(status)")
              }
                if (check == true){
                    print("値の取得")
                    healthSleep.getHealthKitData()
                    check = false
                }
            }
            
    }
    
}


struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        Page1View()
    }
}
