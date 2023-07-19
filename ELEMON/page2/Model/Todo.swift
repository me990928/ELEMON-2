//
//  Todo.swift
//  U22Prot0601
//
//  Created by 中島瑠斗 on 2023/06/13.
//

import Foundation
import RealmSwift

class Todo: Object, Identifiable {
    //@PersistedでそのプロパティがRealmで管理されるべきデータだと設定できる。
    @Persisted var title = ""
    @Persisted var desc = ""
}


//拡張する？的な意味
extension Todo {
    // 追加
    static func addTodo(title: String, desc: String) {
        let todo = Todo()
        todo.title = title
        todo.desc = desc
        
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            localRealm.add(todo)
        }
    }
    
    // 更新
    static func updateTodo(todo: Todo, newTitle: String, newDesc: String) {
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            todo.title = newTitle
            todo.desc = newDesc
        }
    }
    
    // 取得
    static func fetchAllTodo() -> [Todo]? {
        guard let localRealm = try? Realm() else { return nil }
        let todos = localRealm.objects(Todo.self)
        return Array(todos)
    }
    
    // 削除
    static func deleteTodo(todo: Todo) {
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            localRealm.delete(todo)
        }
    }
}
