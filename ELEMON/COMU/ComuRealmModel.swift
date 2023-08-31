//
//  ComuRealmModel.swift
//  ELEMON
//
//  Created by Yuya Hirose on 2023/08/31.
//

import Foundation
import RealmSwift

struct Groups:Hashable{
    var hostId: String
    var name: String
    var context: String
    var owner: String
}

class ComuRealmModel: ObservableObject{
    
    var config = Realm.Configuration.self
    
    private let realm = try! Realm()
    
    var groups: Results<GroupObj>{
        realm.objects(GroupObj.self)
    }
    
    func addGroup(data: Groups){
        let groupOJ = GroupObj()
        groupOJ.hostId = data.hostId
        groupOJ.name = data.name
        groupOJ.context = data.context
        groupOJ.owner = data.owner
        
        try! realm.write{
            realm.add(groupOJ)
            print("123")
        }
    }
    
    func getGroups()-> Results<GroupObj>{
        let data = realm.objects(GroupObj.self)
        return data
    }
    
    func deleteGroup(){
        // ログアウト処理用
        do {
            try realm.write() {
                
                let results = realm.objects(GroupObj.self)
                
                realm.delete(results)
            }
        } catch {
            print("err")
        }
    }
    
}

