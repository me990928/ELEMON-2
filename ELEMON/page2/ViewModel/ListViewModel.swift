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
    @Published var nowValue:Int = 0
    @Published var goalValue:Int = 0
    @Published var check = false
    @Published var updatingTodo: Todo? = nil
        
    init () {
        fetchTodos()
    }
    //fetchTodos関数がデータベースから全てのデータを取得
    func fetchTodos() {
        self.todos = Todo.fetchAllTodo()!
    }
    
    func addTodo() {
        Todo.addTodo(title: title, desc: desc)
        self.title = ""
        self.desc = ""
        fetchTodos()
    }
    // todoリストの更新
    func updateTodo() {
        Todo.updateTodo(todo: updatingTodo!, newTitle: self.title, newDesc: self.desc)
        // 初期化
        self.title = ""
        self.desc = ""
        updatingTodo = nil
        fetchTodos()
    }
    
    //削除
    func deleteTodo(todo: Todo) {
        Todo.deleteTodo(todo: todo)
        fetchTodos()
    }

    static let shared = ListViewModel() // シングルトンとする
}


