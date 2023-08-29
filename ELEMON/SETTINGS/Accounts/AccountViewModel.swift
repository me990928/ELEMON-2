//
//  AccountViewModel.swift
//  ELEMON
//
//  Created by Yuya Hirose on 2023/08/29.
//

import Foundation
import FirebaseAuth

class AccountViewModel: ObservableObject {
    
    private var au = Auth.auth()
    
    @Published var count: Int = 0
    
    // ログイン
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
                                FirestoreModel().addusr(name: name, mail: mail, pass: pass, group: UUID().uuidString)
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
    
}
