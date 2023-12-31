//
//  FireAuth.swift
//  ELEMON
//
//  Created by Yuya Hirose on 2023/06/14.
//

import Foundation
import FirebaseAuth

class FireAuthModel:ObservableObject{
    
    private let au = Auth.auth()
    
    @Published var registFlag:Bool = true
    @Published var loginFlag:Bool = false
    
    // 登録
    func registUser(mail:String, pass:String, name:String){
        au.createUser(withEmail: mail, password: pass){ res,err in
                
                if let user = res?.user {
                    let req = user.createProfileChangeRequest()
                    req.displayName = name
                    req.commitChanges{ err in
                        
                        if err == nil {
                            user.sendEmailVerification() { err in
                                if err == nil {
                                    print("success")
                                    self.registFlag = false
                                    FirestoreModel().addusr(name: name, mail: mail, pass: pass, group: "")
                                }
                            }
                        }
                        
                    }
                    
                }
                
            }
    }
    
    // ログイン
    func loginUser(mail:String,pass:String){
        
         au.signIn(withEmail: mail, password: pass){
            res,err in
            if (res?.user) != nil{
                print("success")
                self.loginFlag = true
            }
        }
    }
    
    // get_ログイン中のユーザ
    func getUserinfo(get:String)->String{
        let user = au.currentUser
        
        let uid = user?.uid
        
        let email = user?.email
        
        let name = user?.displayName
        
        print("uid: \(String(describing: uid))")
        print("email: \(String(describing: email))")
        print("displayName: \(String(describing: user?.displayName))")
        
        switch get {
        case "emil":
            sleep(UInt32(1))
            return email ?? "err";
        case "name":
            sleep(UInt32(1))
            return name ?? "err";
        case "uid":
            sleep(UInt32(1))
            return uid ?? "err"
        default:
            return "err"
        }
    }
    
    // ログアウト
    func logout(){
        do{
            try au.signOut()
            print("success")
        }catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func delete(){
        au.currentUser?.delete(){
            err in
            if let err = err {
                print(err.localizedDescription)
            }else{
                print("success")
            }
        }
    }

    func signin(email:String,pass:String)async throws -> String{
        let res = try await au.signIn(withEmail: email, password: pass)
//        let uid = res.user.uid
        return "1"
    }
    
    func regist(email:String,pass:String,name:String)async -> Bool {
        let res = try await registUser(mail: email, pass: pass, name: name)
//        let res2 = try await au.
        return false
    }
}
