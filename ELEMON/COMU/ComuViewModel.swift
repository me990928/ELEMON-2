//
//  ComuViewModel.swift
//  ELEMON
//
//  Created by Yuya Hirose on 2023/08/30.
//

import SwiftUI
import FirebaseFirestore
import RealmSwift

class ComuViewModel:ObservableObject{
    
    @Published var groups = [Groups]()
    
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
            
            let groups = Groups(hostId: uuid, name: name, context: text, owner: AccountViewModel.UsersItems.uuid.getData)
            
            ComuRealmModel().addGroup(data: groups)
            
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            
            complete(false)
        }
        
    }
    
    func searchGroup(inputText: String, completion: @escaping ([Groups]) -> Void) {
        let db = Firestore.firestore()
        
        if(inputText == ""){
            db.collection("group").whereField("name", isEqualTo: inputText).getDocuments() { snap, err in
                if let snap = snap {
                    var groups: [Groups] = []
                    for snaps in snap.documents {
                        let doc = snaps.data()
                        let hostid = doc["hostId"] as! String
                        let name = doc["name"] as! String
                        let context = doc["context"] as! String
                        let owner = "other"
                        groups.append(Groups(hostId: hostid, name: name, context: context, owner: owner))
                    }
                    completion(groups)
                }
            }
        }else{
            db.collection("group").order(by: "name").start(at: [inputText]).end(at: [inputText + "\u{f8ff}"]).getDocuments() { snap, err in
                if let snap = snap {
                    var groups: [Groups] = []
                    for snaps in snap.documents {
                        let doc = snaps.data()
                        let hostid = doc["hostId"] as! String
                        let name = doc["name"] as! String
                        let context = doc["context"] as! String
                        let owner = "other"
                        groups.append(Groups(hostId: hostid, name: name, context: context, owner: owner))
                    }
                    completion(groups)
                }
            }
        }
    }
}
