//
//  CircularProgressBar.swift
//  U22_Prot
//
//  Created by Yuya Hirose on 2023/05/31.
//

import Foundation
import SwiftUI

struct ProgressBar: View {
    
    @ObservedObject var viewModel = ProgressViewModel()
    
    
    //@State var progressValue2: CGFloat = 0.4
    //@State var progressValue3: CGFloat = 0.4
    
    
    var body: some View {
        
        @State var progressValue:CGFloat = CGFloat(viewModel.nowValue)/CGFloat(viewModel.goalValue)
        
        VStack{
            
            //Text(String(viewModel.goalValue))
            //Text(String(viewModel.nowValue))
            
                        
            ZStack {
                // 背景の円
                Circle()
                // ボーダーラインを描画するように指定
                    .stroke(lineWidth: 24.0)
                    .opacity(0.3)
                    .foregroundColor(.blue)
                
                // 進捗を示す円
                Circle()
                // 始点/終点を指定して円を描画する
                // 始点/終点には0.0-1.0の範囲に正規化した値を指定する
                    .trim(from: 0.0, to: min(progressValue, 1.0))
                // 線の端の形状などを指定
                    .stroke(style: StrokeStyle(lineWidth: 24, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.blue)
                // デフォルトの原点は時計の12時の位置ではないので回転させる
                    .rotationEffect(Angle(degrees: 270.0))
                
                VStack{
                    Text("\(viewModel.goalString)")
                        .foregroundColor(Color.gray)
                    // 進捗率のテキスト
                    Text(String(format: "%.0f%%", min(progressValue, 1.0) * 100.0))
                        .font(.largeTitle)
                        .bold()
                    Text("\(viewModel.nowValue)分/\(viewModel.goalValue)分")
                        .foregroundColor(Color.gray)
                    
                }
                
            }
            .padding()//vstack

            
        }//body
        
    }//view
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar()
    }
}
