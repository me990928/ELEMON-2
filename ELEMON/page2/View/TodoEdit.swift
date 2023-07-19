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
        NavigationView {
            VStack{
                List {
                    ForEach(viewModel.todos) { todo in
                        HStack {
                            Image(systemName: "circlebadge.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .foregroundColor(.blue)
                            VStack {
                                Text(todo.title)
                                    .font(.title3)
                                Text(todo.desc)
                                    .font(.caption2)
                            }
                        }
                        .swipeActions(edge: .trailing) {
                            Button {
                                viewModel.deleteTodo(todo: todo)
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                viewModel.updatingTodo = todo
                                viewModel.title = todo.title
                                viewModel.desc = todo.desc
                                viewModel.isShowAddView.toggle()
                            } label: {
                                Image(systemName: "pencil.circle")
                            }
                            .tint(.green)
                        }
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
                //listはblackの0.05
            }.background(Color.black.opacity(0.05))
            
        }
        
        
    }
    
    
    
    struct TodoEdit_Previews: PreviewProvider {
        static var previews: some View {
            TodoEdit()
        }
    }
}
