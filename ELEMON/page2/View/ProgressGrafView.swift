//
//  ProgressGrafView.swift
//  U22Prot0601
//
//  Created by 中島瑠斗 on 2023/06/13.
//

import SwiftUI

struct ProgressGrafView: View {
    
    @ObservedObject var progressModel = ProgressViewModel.shared
    
    var body: some View {
        VStack{
            GroupBox {
                VStack{
                    Spacer()
                    HStack {
                        Text("一週間の目標").font(.title2).foregroundColor(.primary)
                        Spacer()
                    }
                    ProgressGraf().frame(height: 180).padding()
                    Spacer()
                }
            }.padding()
            
        }

    }
}

struct ProgressGrafView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressGrafView()
    }
}
