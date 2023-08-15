//
//  GoalAddView.swift
//  U22Prot0601
//
//  Created by 中島瑠斗 on 2023/06/14.
//

import SwiftUI

struct GoalAddView: View {
    
    @ObservedObject var viewModel = GoalViewModel()
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedDate = Date()
    @State private var daysRemaining = 0
    private var now = Date()
    
    var body: some View {
        GroupBox{
            HStack{
                Text("目標名：")
                    .foregroundColor(Color(.label))
                TextField("", text: $viewModel.goalTitle).textFieldStyle(.roundedBorder)
            }
            VStack {
                DatePicker("日付を選択してください", selection: $selectedDate, in: now..., displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                
                //Text("選択された日付までの日数: \(daysRemaining)")
                    .font(.title)
                    .padding()
                
                //Spacer()
            }.onChange(of: selectedDate, perform: { date in
                let currentDate = Date()
                let calendar = Calendar.current
                let components = calendar.dateComponents([.day], from: currentDate, to: date)
                
                if let days = components.day {
                    daysRemaining = days
                }
            })
            Button("更新"){
                viewModel.goalNumber = daysRemaining
                dismiss()
            }.buttonStyle(.borderedProminent)
                .padding()
        }//.presentationDetents([.height(300)]).padding()
        .presentationDetents([.fraction(0.8)]).padding()
    }
}

struct GoalAddView_Previews: PreviewProvider {
    static var previews: some View {
        GoalAddView()
    }
}
