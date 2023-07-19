//
//  ColorThema.swift
//  ELEMON
//
//  Created by Yuya Hirose on 2023/07/06.
//

import Foundation

class ColorThema:ObservableObject{
    
    @Published var base = "b1"
    @Published var accent = "a1"
    @Published var text = "te1"
    @Published var tab = "a1"
    
    func regist(i:Int){
        switch i {
        case 0:
            base = "b1"
            accent = "a1"
            text = "te1"
            tab = "a1"
            break
        case 1:
            base = "a2"
            accent = "b2"
            text = "te2"
            tab = "b2"
            break
        case 2:
            base = "a3"
            accent = "b3"
            text = "te3"
            tab = "b3"
            break
        case 3:
            base = "a4"
            accent = "b4"
            text = "te4"
            tab = "b4"
        default:
            base = "b1"
            accent = "a1"
            text = "te1"
            tab = "a1"
            break
        }
    }
    
}
