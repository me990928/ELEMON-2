//
//  AccountViewModel.swift
//  ELEMON
//
//  Created by Yuya Hirose on 2023/08/29.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AccountViewModel: ObservableObject {
    
    private var au = Auth.auth()
    
    @Published var count: Int = 0
    
    
    // ログイン
    func loginUser(mail:String,pass:String, completion: @escaping (Bool) -> Void){
        
         au.signIn(withEmail: mail, password: pass){
            res,err in
            if (res?.user) != nil{
                print("success")
                self.saveData(data: (res?.user.displayName)!, key: UsersItems.name.getKey)
                self.saveData(data: (res?.user.email)!, key: UsersItems.mail.getKey)
                self.saveData(data: (res?.user.uid)!, key: UsersItems.uuid.getKey)
                
                print("Welcome to " + UsersItems.name.getData)
                
                completion(false)
            }else{
                completion(true)
            }
        }
    }
    
    // 登録
    func createUser(mail: String, name: String, pass: String, completion: @escaping (Bool) -> Void) {
        au.createUser(withEmail: mail, password: pass) { res, err in
            if err != nil {
                completion(true) // エラーがある場合はtrueを渡す
            }
            
            if let user = res?.user {
                let req = user.createProfileChangeRequest()
                req.displayName = name
                req.commitChanges { err in
                    if err == nil {
                        user.sendEmailVerification { err in
                            if err == nil {
                                completion(false) // 成功した場合はfalseを渡す
                            } else {
                                completion(true) // エラーがある場合はtrueを渡す
                            }
                        }
                    } else {
                        completion(true) // エラーがある場合はtrueを渡す
                    }
                }
            }
        }
    }
    
    // メールチェック
    func isValidEmail(email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: email)
    }
    
    // 入力チェック
    func inputCheck(data: String)->Bool{
        
        var res = false // 未入力
        
        if data == "" {
            res = true // 入力済み
        }
    
        return res
    }
    
    // サニタイジング
    func sanitizeText(data: String)->String {
        let charSet = CharacterSet.alphanumerics
        
        let sanitizedText = data.unicodeScalars.filter{ charSet.contains($0) }
        
        return String(sanitizedText)
    }
    
    // データ記録
    
    enum UsersItems:String, CaseIterable {
        case name
        case mail
        case pass
        case uuid
    
        var getKey: String{
            switch self {
            case .name:
                return "userName"
            case .mail:
                return "userMail"
            case .pass:
                return "userPass"
            case .uuid:
                return "userUUID"
            }
        }
        
        var getData: String{
            switch self {
            case .name:
                return UserDefaults.standard.string(forKey: "userName") ?? "noName"
            case .mail:
                return UserDefaults.standard.string(forKey: "userMail") ?? "unknown"
            case .pass:
                return UserDefaults.standard.string(forKey: "userPass") ?? "unknown"
            case .uuid:
                return UserDefaults.standard.string(forKey: "userUUID") ?? "unknown"
            }
        }
        
        var deleteData: String{
            switch self {
            case .name:
                UserDefaults.standard.removeObject(forKey: "userName")
            case .mail:
                UserDefaults.standard.removeObject(forKey: "userMail")
            case .pass:
                UserDefaults.standard.removeObject(forKey: "userPass")
            case .uuid:
                UserDefaults.standard.removeObject(forKey: "userUUID")
            }
            return "del"
        }
    }
    
    private let uDf = UserDefaults.standard
    
    func saveData(data: String, key: String){
        uDf.set(data, forKey: key)
        uDf.synchronize()
        
        print("Save")
    }
    
}
