//
//  FirestoreModel.swift
//  chattest
//
//  Created by 広瀬友哉 on 2023/06/09.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

struct messageType: Identifiable {
    var id: String
    var name: String
    var user: String
    var message: String
    var createAt: Date
}

struct userType: Identifiable {
    var id: String
    var name:String
    var mail:String
    var pass:String
    var groupname:String
}

struct groupType: Identifiable {
    var id: String
    var appid: String
    var context: String
    var groupName: String
}

struct groupMembType{
    var userid: String
}

class FirestoreModel:ObservableObject{
    
    
    @Published var userflag: String {
        didSet {
            UserDefaults.standard.set(userflag, forKey: "userflag")
        }
    }
    
    
    @Published var appid: String {
        didSet {
            UserDefaults.standard.set(appid, forKey: "appid")
        }
    }
    
    
    @Published var username: String {
        didSet {
            UserDefaults.standard.set(username, forKey: "username")
        }
    }
    
    @Published var groupid: String {
        didSet {
            UserDefaults.standard.set(groupid, forKey: "groupid")
        }
    }
    
    @Published var mokuhyo: String {
        didSet {
            UserDefaults.standard.set(mokuhyo, forKey: "mokuhyo")
        }
    }
    
    @Published var messages = [messageType]()
    @Published var users = [userType]()
    @Published var groups = [groupType]()
    @Published var groupMembs = [groupMembType]()
    
//    @Published var userflag: Bool = false
    @Published var userName: String = ""
    @Published var userMail: String = ""
    @Published var userPass: String = ""
    
    @Published var delAlt: Bool = false
    @Published var resiAlt:Bool = false
    
    @Published var miss: Bool = false
    @Published var missR: Bool = false
    
    
    @Published var name:[String] = []
    @Published var gname:String = ""
    
    
    var groupID:String = ""
    
    init(){
        
        let au = Auth.auth()
        var id = (au.currentUser?.uid) ?? ""
        let uid = String(describing: id)
        var dip = (au.currentUser?.displayName) ?? ""
        let name = String(describing: dip)
        
        userflag = UserDefaults.standard.string(forKey: "userflag") ?? "false"
        
        appid = UserDefaults.standard.string(forKey: "appid") ?? uid
        
        username = UserDefaults.standard.string(forKey: "username") ?? name
        
        groupid = UserDefaults.standard.string(forKey: "groupid") ?? ""
        
        mokuhyo = UserDefaults.standard.string(forKey: "mokuhyo") ?? ""
        
        let db = Firestore.firestore()
            
        
            db.collection("messages").whereField("groupid", isEqualTo: groupid).addSnapshotListener { snap, err in
                
                print("debug")
                
            if let err = err {
                print("err fetch \(String(describing: err))")
                return
            }
            
            if let snap = snap {
                for i in snap.documentChanges {
                    if i.type == .added {
                        let name = i.document.get("name") as! String
                        let nameid = i.document.get("user") as! String
                        let message = i.document.get("message") as! String
                        let createdAt = i.document.get("createAt", serverTimestampBehavior: .estimate) as! Timestamp
                        let createDate = createdAt.dateValue()
                        let id = i.document.documentID
                        self.messages.append(messageType(id: id, name: name, user:nameid, message: message, createAt: createDate))
                    }
                }
                self.messages.sort{before,after in
                    return before.createAt > after.createAt ? true :false
                }
            }
        }
    }
    // ユーザダブり
    func userReq(name: String,mail: String,pass: String,group: String) {
        
        let db = Firestore.firestore()
        
        let query = db.collection("users")
            .whereField("id", isNotEqualTo: name+mail)
            
            query.getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                    return
                } else {
                    for document in snapshot!.documents {
                        let data = document.data()
                        // データを処理する
                        
                        if let data = data["id"] as? String {
                            if data != "" {
//                                self.addusr(name: name, mail: mail, pass: pass, group: group)
                            }
                        }
                    }
                }
            }        }
    // ユーザ登録
    func addusr(name: String,mail: String,pass: String,group: String) {
        
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "ja_JP")
        dateformatter.dateStyle = .full
        
        let date = Date()
        
        let cd = dateformatter.string(from: date)
        
        let data = [
            "name": name,
            "mail": mail,
            "pass": pass,
            "groupname": group,
            "createDate": cd
//            "id": name + mail
        ]
        
        let db = Firestore.firestore()
        
        let au = Auth.auth()
        
        let id = au.currentUser?.uid
        
        let uid = String(describing: id!)
        
        db.collection("users").document(uid).setData(data) {
            err in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            print("success")
        }
        
        sleep(1)
        
        
        db.collection("users").whereField("mail", isEqualTo: mail).whereField("name", isEqualTo: name).whereField("pass", isEqualTo: pass).whereField("createDate", isEqualTo: cd).getDocuments
        { snap, err in
            if let err = err{
                print(err.localizedDescription)
                return
            }else{
                for docs in snap!.documents{
                    print(docs.documentID)
//                    self.appid = docs.documentID
                    self.resiAlt = true
                }
            }
        }
    }
    
    func inUser(name:String,mail:String,pass:String){
        let db = Firestore.firestore()
        
        
        db.collection("users").document(appid).getDocument { doc, error in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            } else {
                if let data = doc{
                    if let name = data["name"] as? String {
                        if name != name {self.userflag = "false";self.miss = true;return}else{}

                    }

                    if let mail = data["mail"] as? String {
                        if mail != mail {self.userflag = "false";self.miss = true;return}else{self.userMail = mail}
                    }

                    if let name = data["pass"] as? String {
                        if name != pass {self.userflag = "false";self.miss = true;return}else{self.userPass = pass}
                        self.userflag = "true"
//                        self.username = self.userName
                        return
                    }
                    self.miss = true;
                }else {
                    print("Document does not exist")
                }
            }
        }
        

    }
    
    // ユーザ削除
    func delUser(){
        let db = Firestore.firestore()
        
        db.collection("users").document(appid).delete() {
            err in
            if let err = err {
                print(err)
            }else{
                print("Document Removed!")
                self.userflag = "false"
                self.delAlt = true
            }
        }
    }
    
    func delgroup(){
        print(appid)
        
        let db = Firestore.firestore()
        
        db.collection("messages").whereField("groupid", isEqualTo: appid).getDocuments { res, err in
            if let err = err {
                
            }else{
                for docs in res!.documents{
                    db.collection("messages").document(docs.documentID).delete()
                }
            }
        }
        
        db.collection("groups").whereField("appId", isEqualTo: self.appid).getDocuments(completion: { res, err in
            
            if let err = err {
                print(err.localizedDescription)
            }else{
                for docs in res!.documents{
                    print(docs.documentID)
                    db.collection("groups").document(docs.documentID).delete()
                    print(docs.documentID)
                }
                print("Document Removed!")
            }
        })
        
    }
    
    func exitGroup(){
        
        let db = Firestore.firestore()
        
        db.collection("users").document(appid).updateData(["groupname" : "","groupid" : ""])
    }
    
    // groupid と groupnameで同期をとる
    func addGroup(name:String,gid:String,tex:String){
        
        let au = Auth.auth()
        
        let uid = String(describing: (au.currentUser?.uid)!)
        
        let data = [
            "groupName": name, // 検索
            "groupID": gid, // 検索
            "context": tex, // 検索
            "appId": uid, // 紐付け
        ]
        
        let db = Firestore.firestore()
        
        self.groupid = uid
        self.mokuhyo = tex
        
        db.collection("groups").addDocument(data: data) {
            err in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            print("success")
            db.collection("users").document(uid).updateData(["groupname": name,"groupid": uid])
        }
    }
    
    func serchGroup(inputCon:String,inputText:String){
        let db = Firestore.firestore()
        
        self.groups = []
        
        if(inputText == ""){
            db.collection("groups").whereField("context", isEqualTo: inputCon).getDocuments() { snap, err in
                if let snap = snap {
                    for snaps in snap.documents {
                        let doc = snaps.data()
                        let appid = doc["appId"] as! String
                        let context = doc["context"] as! String
                        let groupid = doc["groupID"] as! String
                        let groupname = doc["groupName"] as! String
                        print(groupname)
                        self.groups.append(groupType(id: groupid, appid: appid, context: context, groupName: groupname))
                    }
                }
            }
        }else{
            print("bubun")
            db.collection("groups").whereField("context", isEqualTo: inputCon).order(by: "groupName").start(at: [inputText]).end(at: [inputText + "\u{f8ff}"]).getDocuments() { snap, err in
                if let snap = snap {
                    for snaps in snap.documents {
                        let doc = snaps.data()
                        let appid = doc["appId"] as! String
                        let context = doc["context"] as! String
                        let groupid = doc["groupID"] as! String
                        let groupname = doc["groupName"] as! String
                        print(groupname)
                        self.groups.append(groupType(id: groupid, appid: appid, context: context, groupName: groupname))
                    }
                }
            }
        }
    }
    
    func joinGroup(groupName:String, groupId:String, mokuhyo:String){
        let db = Firestore.firestore()
        let au = Auth.auth()
        let uid = String(describing: (au.currentUser?.uid)!)
        sleep(UInt32(1))
        print(uid)
        db.collection("users").document(uid).updateData(["groupname": groupName, "groupid": groupId])
        
        self.groupid = groupId
        self.mokuhyo = mokuhyo
    }
    
    func changeMokuhyo(data:String){
        let db = Firestore.firestore()
        
        db.collection("groups").whereField("groupID", isEqualTo: groupid).getDocuments() { snap, err in
            if let snap = snap {
                for snaps in snap.documents {
                    db.collection("groups").document(snaps.documentID).updateData(["context" : data])
                    self.mokuhyo = data
                }
            }
        }
    }
    // 送信部
    func addmsg(msg:String){
        let au = Auth.auth()
        let uid = String(describing: (au.currentUser?.uid)!)
        
        let data = [
            "message": msg,
            "name": self.username,
            "createAt":FieldValue.serverTimestamp(),
            "groupid": self.groupid,
            "user": uid
        ] as [String : Any]
        
        let db = Firestore.firestore()
        
        db.collection("messages").addDocument(data: data) {
            err in
            if let err = err {
                print (err.localizedDescription)
                return
            }
            
            print("success")
            print(self.username)
        }
    }
    
    func getGroupData(){
        let db = Firestore.firestore()
        self.name = []
    
        db.collection("users").whereField("groupid", isEqualTo: self.groupid).getDocuments { snap, err in
            if let snap = snap{
                for i in snap.documents {
                    let data = i.data()
                    self.name.append(data["name"] as! String)
                    self.gname = data["groupname"] as! String
                }
            }
        }
    }
}
