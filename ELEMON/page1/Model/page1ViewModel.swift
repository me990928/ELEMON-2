//
//  page1ViewModel.swift
//  ELEMON
//
//  Created by Yuya Hirose on 2023/06/17.
//

import Foundation

class Page1ViewModel:ObservableObject{
    
//    var i:Int = 0
//    var r:Int = 0
//    var h:Int = 0
//    var o:Int = 0
    
    var i: Void = UserDefaults.standard.register(defaults: ["undo":[0,1,2]])
    var c: Void = UserDefaults.standard.register(defaults: ["counter":[0,0,0,0,0,0,0,0]])

    var bed:Float = 0
    var step:Float = 0
    var harts:Float = 0
    var cal:Float = 0
    var act:Float = 0
    var water:Float = 0
    var body:Float = 0
    var mind:Float = 0
    
    func counter(i:Int){
        undo(i: i)
        doCount(i: i)
    }
    
    func undo(i:Int){
        // 値被り防止策
        var arr:[Int] = UserDefaults.standard.value(forKey: "undo") as! [Int]
        
        arr.insert(i, at: 0)
        arr.removeLast()
        
        UserDefaults.standard.set(arr, forKey: "undo")
//        print(UserDefaults.standard.value(forKey: "undo") ?? "none")
    }
    
    func mainViewReader(i:Int) -> Int{
        let arr:[Int] = UserDefaults.standard.value(forKey: "undo") as! [Int]
        return arr[i]
    }
    
    func doCount(i:Int){
        var arr:[Int] = UserDefaults.standard.value(forKey: "counter") as! [Int]
        let s = arr[i] + 1
        arr.insert(s, at: i)
        arr.removeLast()
        UserDefaults.standard.set(arr, forKey: "counter")
        print(UserDefaults.standard.value(forKey: "counter") ?? "none")
    }
    
    func topIcon() -> Int{
        let arr:[Int] = UserDefaults.standard.value(forKey: "counter") as! [Int]
        let res = arr.firstIndex(of: arr.max() ?? 0)
        print(res!)
        return Int(res ?? 0)
    }
    
}
