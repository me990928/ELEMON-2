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
    @Persisted var id: String = UUID().uuidString
    @Persisted var title = ""
    @Persisted var desc = ""
    @Persisted var check: Bool
    @Persisted var hid: Bool
}


//拡張する？的な意味
extension Todo {
    // 追加
    static func addTodo(title: String, desc: String, check: Bool, hid: Bool) {
        let todo = Todo()
        todo.title = title
        todo.desc = desc
        todo.check = check
        todo.hid = hid
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            localRealm.add(todo)
        }
    }
    
    // 更新
    static func updateTodo(todo: Todo, newTitle: String, newDesc: String, newCheck: Bool, newHid: Bool) {
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            todo.title = newTitle
            todo.desc = newDesc
            todo.check = newCheck
            todo.hid = newHid
        }
    }
    
    // 取得
    static func fetchAllTodo() -> [Todo]? {
        //print("ここだよ",Realm.Configuration.defaultConfiguration.fileURL!)
        guard let localRealm = try? Realm() else { return nil }
        let todos = localRealm.objects(Todo.self)
        return Array(todos)
    }
    
    //check
    static func updateSecondTodo(todo: Todo) {
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            todo.check = !todo.check
        }
        
    }
    
    //hidden
    static func updateThirdTodo(todo: Todo) {
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            todo.hid = !todo.hid
        }
        
    }
    
    static func hiddenTodo() {
        guard let localRealm = try? Realm() else { return }
        let targetItems = localRealm.objects(Todo.self).filter("check == true").filter("hid == false")
        try? localRealm.write {
            for item in targetItems {
                item.hid = !item.hid
            }
        }
        
    }
    
    // 削除
    static func deleteTodo(todo: Todo) {
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            localRealm.delete(todo)
        }
        //let todo = Todo()
    }
    
    static func deleteAll() {
        guard let localRealm = try? Realm() else { return }
        let targetItem = localRealm.objects(Todo.self).filter("check == false")
        try? localRealm.write {
            localRealm.delete(targetItem)
        }
        //let todo = Todo()
    }
    
    
 }
