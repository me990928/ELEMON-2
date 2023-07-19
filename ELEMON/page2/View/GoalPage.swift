//
//  ContentView.swift
//  goalPage
//
//  Created by 中島瑠斗 on 2023/05/17.
//

import SwiftUI
import UIKit

struct GoalPage: View {
    
    @State var sheet:Bool = false
    @State var sheetGoal:Bool = false
    
    var body: some View {
            NavigationView{
                VStack {
                    HStack{
                        Spacer()
                        Button("編集"){
                            self.sheetGoal.toggle()
                        }.font(.title3)                 .padding(.trailing, 20.0)  .foregroundColor(Color(.label))
                            .sheet(isPresented: $sheetGoal) {
                                GoalAddView()
                            }
                    }//hsta
                    GoalCount()
                        .frame(height:90)
                    
                    HStack{
                        Text("目標")
                            .font(.title)
                            .padding(.leading, 20.0)
                        Spacer()

                        Button("編集"){
                            self.sheet.toggle()
                        }.font(.title3)                 .padding(.trailing, 20.0)  .foregroundColor(Color(.label))
                            .sheet(isPresented: $sheet) {
                                ProgressAddView()
                            }
                    }
                    ZStack{
                        ProgressBar()
                        NavigationLink(destination: ProgressGrafView()){
                            Circle()
                                .foregroundColor(.clear)
                        }
                    }.frame(height: 200)
                    
                    
                    //タイトル
                    HStack{
                        Text("ToDo")
                            .font(.title)
                            .padding(.leading, 20.0)
                        Spacer()
                        NavigationLink(destination: TodoEdit()){
                            Text("一覧")
                        }.font(.title3)
                            .padding(.trailing, 20.0)
                            .foregroundColor(Color(.label))
                    }//タイトル
                    TodoList()
                    Spacer()
                }//vstack
            }//navigationView
    }//body
    
}//view



struct GoalPage_Previews: PreviewProvider {
    static var previews: some View {
        GoalPage()
    }
}
