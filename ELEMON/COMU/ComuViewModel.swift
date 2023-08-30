//
//  ComuViewModel.swift
//  ELEMON
//
//  Created by Yuya Hirose on 2023/08/30.
//

import SwiftUI
import FirebaseFirestore
import RealmSwift

class ComuViewModel{
    
    func createGroup(name: String, text: String, complete: @escaping (Bool)->Void){
        let db = Firestore.firestore()
        
        let uuid = UUID().uuidString
        
        let date = FieldValue.serverTimestamp()
        
        let data = [
            "hostId": uuid,
            "name": name,
            "context": text,
            "creatAt": date,
            "lastAt": date
        ] as [String : Any]
        
        db.collection("group").addDocument(data: data) {
            err in
            if let err = err {
                print (err.localizedDescription)
                return
            }
            
            var groups = Groups(hostId: uuid, name: name, context: text)
            
            ComuRealmModel().addGroup(data: groups)
            
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            
            complete(false)
        }
        
    }
    
    func saveGroup(){
        
    }
    
}
