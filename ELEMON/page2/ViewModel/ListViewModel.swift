//
//  ListViewModel.swift
//  U22Prot0601
//
//  Created by 中島瑠斗 on 2023/06/13.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var isShowAddView = false
    @Published var todos: [Todo] = []
    @Published var title = ""
    @Published var desc = ""
    @Published var updatingTodo: Todo? = nil
        
    init () {
        fetchTodos()
    }
    
   
    //fetchTodos関数がデータベースから全てのデータを取得
    func fetchTodos() {
        self.todos = Todo.fetchAllTodo()!
        //print(self.todos)
    }
    
    func addTodo() {
        Todo.addTodo(title: title, desc: desc, check: false, hid: false)
        self.title = ""
        self.desc = ""
        fetchTodos()
    }
    // todoリストの更新
    func updateTodo() {
        Todo.updateTodo(todo: updatingTodo!, newTitle: self.title, newDesc: self.desc, newCheck: false, newHid: false)
        // 初期化
        self.title = ""
        self.desc = ""
        updatingTodo = nil
        fetchTodos()
    }
    
    //check
    func updateItemModel(todo: Todo){
        Todo.updateSecondTodo(todo: todo)
        fetchTodos()
    }
    
    //hidden
    func changeItemModel(todo: Todo){
        Todo.updateThirdTodo(todo: todo)
        fetchTodos()
    }
    
    //hiddenTodo
    func hiddenTodo(){
        Todo.hiddenTodo()
        fetchTodos()
        
    }
    
    //削除
    func deleteTodo(todo: Todo) {
        Todo.deleteTodo(todo: todo)
        fetchTodos()
    }
    
    //全消去
    func deleteAll(){
        Todo.deleteAll()
        fetchTodos()
        
    }

    static let shared = ListViewModel() // シングルトンとする
}


