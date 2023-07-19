//
//  ContentView.swift
//  game
//
//  Created by 広瀬友哉 on 2023/06/26.
//

import SwiftUI

struct ContentView123421: View {
    @AppStorage ("firstUp") var c:Int = 0
    
    @Environment(\.scenePhase) private var scenePhase
    
    var char = CharModel()
    
    var body: some View {
        VStack{
            ZStack{
                CharView().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all)
                VStack{
                    Spacer()
                    MenuView().padding(15)
                }
            }
        }
        .onChange(of: scenePhase, perform: { Phase in
            if (Phase == .background){
                self.char.upLove()
                self.char.saveStatusDate()
                print("back")
            }
            if (Phase == .active){
                print("act1")
                if (self.char.timeDifference() > 15){
                    var before = self.char.loadChar()
                    before.hang -= self.char.timeDifference() / 15
                    if (before.hang < 0) { before.hang = 0; before.health -= self.char.timeDifference() / 20 }
                    if (before.health < 0) { before.health = 0 }
                    self.char.saveChar(chData: before)
                    char.countRest(c: self.char.timeDifference() / 20)
                }
            }
            self.char.setDate()
//            self.char.timeDifference()
            self.char.saveDate()
            
        })
        .onAppear(){
            c += 1
            if (c == 1) {
                char.initChar()
            }
            
//            self.char.setDate()
//            print(self.char.timeDifference())
//            self.char.saveDate()
//            print("taa")
        }
    }
}
struct ContentView_Previews12121: PreviewProvider {
    static var previews: some View {
        ContentView123421().environmentObject(FirestoreModel()).environmentObject(FireAuthModel()).environmentObject(HealthSleep()).environmentObject(TabModel())
    }
}
