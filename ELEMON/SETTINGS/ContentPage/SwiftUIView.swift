//
//  SwiftUIView.swift
//  page4
//
//  Created by 広瀬友哉 on 2023/05/30.
//

import SwiftUI

struct SwiftUIView: View {
    
    @EnvironmentObject var css:ColorThema
    
    @AppStorage ("css") var cflag = 0
    
    @State var alertFlag:Bool = false
    
   @State var lists:[[String]] = [
    
    ["マリンブルー","false","0"],
        ["パーシモン","false","1"],
        ["蜜柑色","false","2"],
        ["青丹","false","3"]
    
    ]
    
    var body: some View {
        
        
        List{
        ForEach(lists, id: \.self) { val in
            Button {
                alertFlag = true
                for i in 0..<lists.count {
                    lists[i][1] = "false"
                }
                lists[Int(val[2]) ?? 0][1] = "true"
                cflag = Int(val[2]) ?? 0
                
            } label: {
                HStack{
                    Text(val[0])
                    Spacer()
                    if(val[1] == "true"){
                        Image(systemName: "star.fill").foregroundColor(.yellow)
                    }
                }
            }.alert("変更完了！",isPresented: $alertFlag) {
                
            }

        }
        }.onAppear(){
            self.lists[cflag][1] = "true"
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView().environmentObject(ColorThema())
    }
}
