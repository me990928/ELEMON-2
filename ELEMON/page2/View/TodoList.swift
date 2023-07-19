//
//  TodoList.swift
//  U22Prot0601
//
//  Created by 中島瑠斗 on 2023/06/13.
//

import SwiftUI

struct TodoList: View {
    
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
                            //ここで完了と切り替え
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
                .listStyle(PlainListStyle())
                .scrollContentBackground(.hidden)
            }
        }
    }
    
    
    //Image(systemName: items[index].isChecked ? "checkmark.square" : "square")
    //    .onTapGesture {
    //        items[index].isChecked.toggle()
    //    }
    
    struct TodoList_Previews: PreviewProvider {
        static var previews: some View {
            TodoList()
        }
    }
}
