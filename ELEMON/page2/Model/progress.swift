//
//  progress.swift
//  ELEMON
//
//  Created by 中島瑠斗 on 2023/08/13.
//

import Foundation
import RealmSwift

class Progress: Object, Identifiable {
    @Persisted var id: String = UUID().uuidString
    @Persisted var value = 0
    @Persisted var date = ""

}

extension Progress {
    //追加
    static func addProgress(value: Int, date: String) {
        let progress = Progress()
        progress.value = value
        progress.date = date
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            localRealm.add(progress)
        }
    }
    static func updateProgress(newValue: Int, date: String) {
        
        guard let localRealm = try? Realm() else { return }
        //realmのfilterで変数を使用したい場合は%@で置き換えをする
        let pro = localRealm.objects(Progress.self).filter("date == %@", date)
        try? localRealm.write {
            pro.first?.value = newValue
        }
    }
    
    // 取得
    static func fetchAllProgress() -> [Progress]? {
        //print("ここだよ",Realm.Configuration.defaultConfiguration.fileURL!)
        guard let localRealm = try? Realm() else { return nil }
        let progress = localRealm.objects(Progress.self)
        return Array(progress)
    }
    
//    static func tameshi(){
//        let progress = Progress()
//        progress.value = 32
//        progress.date = "07/28"
//        guard let localRealm = try? Realm() else { return }
//        try? localRealm.write {
//            localRealm.add(progress)
//        }
//    }
}


