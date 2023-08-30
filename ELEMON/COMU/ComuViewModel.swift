//
//  ComuViewModel.swift
//  ELEMON
//
//  Created by Yuya Hirose on 2023/08/30.
//

import SwiftUI
import FirebaseFirestore

class ComuViewModel{
    
    func createGroup(name: String, text: String, complete: @escaping (Bool)->Void){
        let db = Firestore.firestore()
        
        let uuid = UUID().uuidString
        
        let data = [
            "hostId": uuid,
            "name": name,
            "context": text,
            "creatAt": FieldValue.serverTimestamp()
        ] as [String : Any]
        
        db.collection("group").addDocument(data: data) {
            err in
            if let err = err {
                print (err.localizedDescription)
                return
            }
            complete(false)
        }
        
    }
    
}
