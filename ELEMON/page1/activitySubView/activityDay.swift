//
//  activityDay.swift
//  page1
//
//  Created by 広瀬友哉 on 2023/05/11.
//

import SwiftUI

struct activityDay: View {
    var body: some View {
        GeometryReader{ geoval in
            VStack{
                HStack{
                    Image(systemName: "figure.run").font(.title)
                        .padding(.trailing)
                    Text("アクティブ").font(.title)
                    Spacer()
                }
                GroupBox {
                    Text("").frame(width: geoval.size.width * 0.9)
                }
            }
        }.padding()
    }
}

struct activityDay_Previews: PreviewProvider {
    static var previews: some View {
        activityDay()
    }
}
