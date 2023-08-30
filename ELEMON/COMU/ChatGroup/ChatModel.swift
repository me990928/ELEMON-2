//
//  ChatModel.swift
//  ELEMON
//
//  Created by Yuya Hirose on 2023/08/31.
//

import Foundation
import FirebaseFirestore

struct Comments: Hashable{
    var ID: String
    var userId: String
    var name: String
    var text: String
    var groupId: String
    var createAt: Date
}

class ChatModel:ObservableObject{
    
    var groups: String
    
    @Published var messages = [Comments]()
    
    init(groupid: String){
        
        self.groups = groupid
        
        let db = Firestore.firestore()
            
        
        db.collection("messages").whereField("groupID", isEqualTo: self.groups).order(by: "createAt", descending: true).addSnapshotListener { snap, err in
            
            print("debug")
            
            if let err = err {
                print("err fetch \(String(describing: err))")
                return
            }
            
            if let snap = snap {
                for i in snap.documentChanges {
                    if i.type == .added {
                        let userId = i.document.get("userID") as! String
                        let text = i.document.get("text") as! String
                        let groupId = i.document.get("groupID") as! String
                        let createdAt = i.document.get("createAt", serverTimestampBehavior: .estimate) as! Timestamp
                        let createDate = createdAt.dateValue()
                        let ownerName = i.document.get("ownerName") as! String
                        let id = i.document.documentID
                        self.messages.append(Comments(ID: id, userId: userId, name: ownerName, text: text, groupId: groupId, createAt: createDate))
                    }
                }
//                self.messages.sort{before,after in
//                    return before.createAt > after.createAt ? true :false
//                }
            }
            
            print("realtime")
        }
    }
    
    
    // 送信部
    func senfMsg(msg:String, groupId:String){
        
        let data = [
            "userID": AccountViewModel.UsersItems.uuid.getData,
            "ownerName": AccountViewModel.UsersItems.name.getData,
            "text": msg,
            "groupID": groupId,
            "createAt": FieldValue.serverTimestamp()
        ] as [String : Any]
        
        let db = Firestore.firestore()
        
        db.collection("messages").addDocument(data: data) {
            err in
            if let err = err {
                print (err.localizedDescription)
                return
            }
            
            print("success")
        }
    }
    
}
