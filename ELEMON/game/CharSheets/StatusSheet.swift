//
//  StatusSheet.swift
//  game
//
//  Created by 広瀬友哉 on 2023/06/27.
//

import SwiftUI

struct StatusSheet: View {
    
    var char = CharModel()
    
    @State var data:StatusChar
    
    @State var charStatus:StatusChar
    
    @State var love:String = ""
    @State var hang:String = ""
    @State var health:String = ""
    
    var body: some View {
        List{
            Text("名前：\(self.charStatus.name)")
            Text("お世話日数：\(self.charStatus.date)")
            Text("仲良し度：\(self.love)")
            Text("満腹度：\(self.hang)")
            Text("健康度：\(self.health)")
        }.onAppear(){
            
            self.data = char.loadChar()
            self.charStatus.name = data.name
            self.charStatus.date = data.date
            self.charStatus.love = data.love
            self.charStatus.hang = data.hang
            self.charStatus.health = data.health
            
            for _ in 0..<self.charStatus.love{
                self.love += "❤️"
            }
            for _ in 0..<self.charStatus.hang{
                self.hang += "🍖"
            }
            for _ in 0..<self.charStatus.health{
                self.health += "⭐️"
            }
        }
    }
}

struct StatusSheet_Previews: PreviewProvider {
    static var previews: some View {
        StatusSheet(data: CharModel().err, charStatus: CharModel().err)
    }
}
