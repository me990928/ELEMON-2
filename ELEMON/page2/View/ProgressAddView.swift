//
//  ProgressAddView.swift
//  U22Prot0601
//
//  Created by 中島瑠斗 on 2023/06/14.
//

//
//  ActiveAddView.swift
//  U22Prot0601
//
//  Created by 中島瑠斗 on 2023/06/13.
//

import SwiftUI

struct ProgressAddView: View {
    @ObservedObject var viewModel = ProgressViewModel()
    @Environment(\.dismiss) var dismiss
    
    @State var nowValue:Int = 0
    @State var goalValue:Int = 0
    
    
    var body: some View {
        
        //これで保存されているか確かめられる
        //Text("UserDefaultsの値:\(UserDefaults.standard.integer(forKey: "nowValue"))")
        
        VStack{
            Spacer()
            
            Text("目標名").font(.title2)
            
            HStack{
                TextField("",text: $viewModel.goalString)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 200)
                    .multilineTextAlignment(TextAlignment.center)
            }.padding(.bottom, 10.0)
            
            Text("1日の目標勉強時間").font(.title2)
            
            HStack{
                TextField("",value: $viewModel.goalValue,formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 100)
                    .multilineTextAlignment(TextAlignment.center)
                Text("分")
            }.padding(.bottom, 10.0)
            
            
            
            Text("今日の勉強時間").font(.title2)
            
            HStack{
                TextField("",value: $viewModel.nowValue,formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 100)
                    .multilineTextAlignment(TextAlignment.center)
                Text("分")
            }.padding(.bottom, 10.0)
            
            
            Button("完了"){
                dismiss()
            }
            Spacer()
        }.presentationDetents([.medium])
        
    }
}

struct ProgressAddView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressAddView()
    }
}
