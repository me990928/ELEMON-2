//
//  AccountViewModel.swift
//  ELEMON
//
//  Created by Yuya Hirose on 2023/08/29.
//

import Foundation

class AccountViewModel {
    
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
