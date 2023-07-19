//
//  MokuhyoTopView.swift
//  Comu
//
//  Created by 広瀬友哉 on 2023/05/25.
//

import SwiftUI

struct MokuhyoTopView: View {
    
    @State var progressValue: CGFloat = 0.3
    
    @EnvironmentObject var fireSt: FirestoreModel
    
    
    var body: some View {
        GeometryReader{ geoVal in
            VStack {
                Text("グループ名：\(fireSt.gname)")
                Text("目標：\(fireSt.mokuhyo)")
                
                GroupBox {
                    VStack(alignment: .leading){
                        HStack{Spacer()}
                        HStack {
                            Spacer()
                            Text("メンバー").font(.title).padding()
                            Spacer()
                        }
                        ForEach(fireSt.name, id: \.self) {
                            i in
                            Text("\(i)")
                            Divider()
                        }
                    }
                }.padding()
            }.onAppear(
                perform: fireSt.getGroupData
            )
        }
    }
}
struct MokuhyoTopView_Previews: PreviewProvider {
    static var previews: some View {
        MokuhyoTopView()
    }
}
