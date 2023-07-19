//
//  CharModel.swift
//  game
//
//  Created by Yuya Hirose on 2023/06/28.
//

import Foundation

struct StatusChar:Codable{
    var name:String
    var date:Int
    var love:Int
    var hang:Int
    var health:Int
}

class CharModel{
    var firstChar = StatusChar(name: "金髪フード娘", date: 0, love: 0, hang: 3, health: 5)
    var err = StatusChar(name: "err", date: 0, love: 0, hang: 0, health: 0)
    
    func downLove(){
        var before = self.loadChar()
        
        before.love -= 1
        
        if before.love < 0 {before.love = 0}
        
        self.saveChar(chData: before)
        
    }
    
    func countRest(c:Int){
        var i = UserDefaults.standard.integer(forKey: "health")
        i -= c
        if i < 0 {i = 0}
        UserDefaults.standard.set(i, forKey: "health")
        print(UserDefaults.standard.integer(forKey: "health"))
    }
    
    func upLove(){
        let l = UserDefaults.standard.integer(forKey: "love")
        
        if l/5 >= 1 {
            var before = self.loadChar()
            
            before.love += l/5
            
            self.saveChar(chData: before)
            
            UserDefaults.standard.set(0, forKey: "love")
        }
        if loadChar().love > 5{
            var before = self.loadChar()
            before.love = 5
            self.saveChar(chData: before)
            UserDefaults.standard.set(0, forKey: "love")
        }
    }
    
    func downHealth(){
        var h = UserDefaults.standard.integer(forKey: "health")
        var before = self.loadChar()
        
        if (h/5 >= 1){
            before.health -= 1
            h = 0
            self.saveChar(chData: before)
            print("a\(loadChar().health)")
        }
        
        if before.health < 0 {
            before.health = 0
            h = 0
            self.saveChar(chData: before)
        }
        
        
        downLove()
        
        UserDefaults.standard.set(h, forKey: "health")
    }
    
    func eatSweet(){
        var before = self.loadChar()
        
        before.hang += 1
        
        var l = UserDefaults.standard.integer(forKey: "love")
        l += 2
        UserDefaults.standard.set(l, forKey: "love")
        
        if before.hang >= 5 {
            var c = UserDefaults.standard.integer(forKey: "health")
            c += 2
            UserDefaults.standard.set(c, forKey: "health")
            
            before.hang = 5
            
            print(c)
        }
        
        self.saveChar(chData: before)
        
    }
    
    func eatRice(){
        var before = self.loadChar()
        
        before.hang += 1
        
        if before.hang >= 5 {
            var c = UserDefaults.standard.integer(forKey: "health")
            c += 1
            UserDefaults.standard.set(c, forKey: "health")
            
            before.hang = 5
            
            print(c)
            
        }
        
        self.saveChar(chData: before)
        
    }
    
    func upHealth(){
        var before = self.loadChar()
        
        if (before.health < 5){
            before.health += 2
        }
        if before.health > 5 {
            before.health = 5
        }
        self.saveChar(chData: before)
        UserDefaults.standard.set(0, forKey: "health")
    }
    
    // 最後の時間
    func saveStatusDate(){
        UserDefaults.standard.set(Date(), forKey: "STDATE")
    }
    
    func timeDifference() -> Int {
        let start = UserDefaults.standard.object(forKey: "STDATE") as? Date
        let last = Date()
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.minute], from: start ?? Date(), to: last)
        return comp.minute ?? 0
    }
    
    // 最後の時間
    func saveDate(){
        UserDefaults.standard.set(Date(), forKey: "DATE")
    }
    
    // お世話日をセット
    func setDate(){
        if let lastDate = UserDefaults.standard.object(forKey: "DATE") as? Date {
            let nowDate = Date()
            if Calendar.current.isDate(nowDate, inSameDayAs: lastDate){
                print("not next date")
            }else{
                var before = self.loadChar()
                before.date += 1
                self.saveChar(chData: before)
            }
        }
        
        
    }
    
    
    
    // 初回セーブ
    func initChar(){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self.firstChar)
            UserDefaults.standard.set(data, forKey: "CHAR")
        } catch {
            print("Failed to Save \(error)")
        }
    }
    
    // セーブ
    func saveChar(chData:StatusChar){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(chData)
            UserDefaults.standard.set(data, forKey: "CHAR")
        } catch {
            print("Failed to Save \(error)")
        }
    }
    
    // ロード
    func loadChar() -> StatusChar {
        if let data = UserDefaults.standard.data(forKey: "CHAR") {
            do {
                let decoder = JSONDecoder()
                let char = try decoder.decode(StatusChar.self, from: data)
                return char
            }catch {
                print("Failed to Save \(error)")
            }
        }
        return self.err
    }
    
    
    
}
