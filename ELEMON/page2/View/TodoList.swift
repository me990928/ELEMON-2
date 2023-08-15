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
                .listStyle(PlainListStyle())
                .scrollContentBackground(.hidden)
            }
        }
    }
    
    
    struct TodoList_Previews: PreviewProvider {
        static var previews: some View {
            TodoList()
        }
    }
}
