//
//  thirdNav.swift
//  goalPage
//
//  Created by 中島瑠斗 on 2023/05/24.
//

import SwiftUI

struct TodoEdit: View {
    
    @ObservedObject var viewModel = ListViewModel.shared
    
    
    var body: some View {
        VStack{
            List {
                //テスト用
                Section(header: Text("未完了")) {
                    ForEach(viewModel.todos.filter({ !$0.check && !$0.hid })) { todo in
                        HStack {
                            Image(systemName:todo.check ? "checkmark.square":"square" ).foregroundColor(todo.check ? Color.red: Color.green)
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .onTapGesture {
                                    withAnimation(.linear){
                                        viewModel.updateItemModel(todo: todo)
                                    }
                                }
                            VStack {
                                Text(todo.title)
                                    .font(.title3)
                                Text(todo.desc)
                                    .font(.caption2)
                                
                            }
                            Spacer()
                            Text("削除")
                                .onTapGesture {
                                    withAnimation(.linear){
                                        viewModel.changeItemModel(todo: todo)
                                    }
                                    
                                }
                        }
                    }//
                }
                Section(header: headerView()) {
                    
                    ForEach(viewModel.todos.filter({ $0.check && !$0.hid })) { todo in
                        HStack {
                            Image(systemName:todo.check ? "checkmark.square":"square" ).foregroundColor(todo.check ? Color.red: Color.green)
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .onTapGesture {
                                    withAnimation(.linear){
                                        viewModel.updateItemModel(todo: todo)
                                    }
                                }
                            VStack {
                                Text(todo.title)
                                    .font(.title3)
                                Text(todo.desc)
                                    .font(.caption2)
                            }
                            Spacer()
                            Text("削除")
                                .onTapGesture {
                                    withAnimation(.linear){
                                        viewModel.changeItemModel(todo: todo)
                                    }
                                    
                                }
                        }
                    }//for
                    
                }
            }
            .navigationTitle("ToDo一覧")
            HStack{
                Spacer()
                Button(action: {viewModel.isShowAddView.toggle()}) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                }.frame(width: 60, height: 60)
                    .background(Color.blue)
                    .cornerRadius(30.0)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 25.0))
                    .sheet(isPresented: $viewModel.isShowAddView) {
                        AddView()
                    }
            }//hsta
            
        }.background(Color.black.opacity(0.05))
        
    }
    
    
    
    struct TodoEdit_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView {
                TodoEdit()
            }
            
        }
    }
}

