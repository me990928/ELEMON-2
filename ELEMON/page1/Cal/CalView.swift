//
//  ContentView.swift
//  waterPage
//
//  Created by 中島瑠斗 on 2023/05/11.
//

import SwiftUI


// プログレスバーのビュー
struct CalView: View {
    @ObservedObject var viewModel = ActivityModel()
    @State var sheetFlag: Bool = false
    
    let newMaxValues = Array(500...5000)
    @State var newMaxValue:Double = 500
    
    var body: some View {
        @State var progressValue:CGFloat = CGFloat(viewModel.nowCal)/CGFloat(viewModel.goalCal)

        ScrollView(.vertical){
            VStack{
                HStack{
                    Image(systemName: "figure.walk").font(.title).padding().foregroundColor(.primary)
                    Text("カロリー")
                        .font(.title).foregroundColor(.primary)
                    Spacer()
                    Button {
                        self.sheetFlag = true
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 50)
                            
                            Image(systemName: "gearshape")
                                .foregroundColor(Color(.white))
                                .font(.title)
                        }
                    }
                    .foregroundColor(.orange)
                    .sheet(isPresented: $sheetFlag) {
                        // ここからシートの内容を書いてください
                        VStack {
                            Text("新しい最大値を選択してください")
                                .font(.headline)
                                .padding()
                            
                            Slider(value: Binding<Double>(
                                get: { newMaxValue },
                                set: { newValue in
                                    newMaxValue = newValue
                                }
                            ), in: Double(newMaxValues.min()!)...Double(newMaxValues.max()!), step: 1)
                            .padding(.horizontal)
                            
                            HStack {
                                Button(action: {
                                    newMaxValue -= 1
                                    if newMaxValue < Double(newMaxValues.min()!) {
                                        newMaxValue = Double(newMaxValues.min()!)
                                    }
                                }, label: {
                                    Image(systemName: "minus")
                                })
                                .foregroundColor(.orange)
                                
                                Text("\(Int(newMaxValue))")
                                    .font(.headline)
                                    .foregroundColor(Color(.label))
                                
                                Button(action: {
                                    newMaxValue += 1
                                    if newMaxValue > Double(newMaxValues.max()!) {
                                        newMaxValue = Double(newMaxValues.max()!)
                                    }
                                }, label: {
                                    Image(systemName: "plus")
                                })
                                .foregroundColor(.orange)
                            }
                            .padding(.horizontal)
                            
                            Button(action: {
                                viewModel.goalCal = Int(newMaxValue.rounded())
                                progressValue = CGFloat(viewModel.nowCal) / CGFloat(viewModel.goalCal)
                                sheetFlag = false
                            }, label: {
                                Text("適用")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.orange)
                                    .cornerRadius(10)
                            })
                            .padding()
                            
                            Button(action: {
                                newMaxValue = Double(viewModel.goalCal)
                                sheetFlag = false
                            }, label: {
                                Text("キャンセル")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.orange)
                                    .cornerRadius(10)
                            })
                            .padding()
                        }
                        // シートのサイズ
                        Spacer().frame(height: 0)
                            .presentationDetents([.medium])
                    }
                }
                VStack{
                    
                    //Text(String(viewModel.goalValue))
                    //Text(String(viewModel.nowValue))
                    let purpleAngularGradient = AngularGradient(
                        gradient: Gradient(colors: [
                            Color(red: 255/255, green: 180/255, blue: 0/255),
                            Color(red: 253/255, green: 126/255, blue: 0/255)
                            
                            
                            //ここのコメントアウトをなくして、上をコメントアウトしてください
                            
                            //Color("\(colorStart)"),
                            //Color("\(colorEnd)")
                        ]),
                        center: .center,
                        startAngle: .degrees(0),
                        endAngle: .degrees(360.0 * progressValue))
                    
                    ZStack {
                        // 背景の円
                        Circle()
                        // ボーダーラインを描画するように指定
                            .stroke(lineWidth: 24.0)
                            .opacity(0.3)
                            .foregroundColor(.orange)
                        
                        // 進捗を示す円
                        Circle()
                        // 始点/終点を指定して円を描画する
                        // 始点/終点には0.0-1.0の範囲に正規化した値を指定する
                            .trim(from: 0.0, to: min(progressValue, 1.0))
                        // 線の端の形状などを指定
                            .stroke(purpleAngularGradient,style: StrokeStyle(lineWidth: 24, lineCap: .round, lineJoin: .round))
                            .foregroundColor(.orange)
                        // デフォルトの原点は時計の12時の位置ではないので回転させる
                            .rotationEffect(Angle(degrees: 270.0))
                        
                        VStack{
                            Text("\(viewModel.goalCalString)")
                                .foregroundColor(Color.gray)
                            // 進捗率のテキスト
                            Text(String(format: "%.0f%%", min(progressValue, 5.0) * 100.0))
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(Color(.label))
                            Text("\(viewModel.nowCal)kcal/\(viewModel.goalCal)kcal")
                                .foregroundColor(Color.gray)
                            
                        }
                        
                    }
                    .padding()
                    
                    
                }//body
                .frame(width: 250,height: 250)
                .padding(.bottom, 40.0)
                HStack {
                    Button {
                        if viewModel.nowCal > 0 {
                            viewModel.nowCal -= 1
                            progressValue = CGFloat(viewModel.nowCal) / CGFloat(viewModel.goalCal)
                        }
                    } label: {
                        Text("-1kcal")
                            .bold()
                            .padding()
                            .frame(width: 160, height: 80)
                            .foregroundColor(Color.white)
                            .background(Color(.orange))
                            .cornerRadius(10)
                    }
                    
                    Button {
                        viewModel.nowCal += 1
                        viewModel.nowCal = min(viewModel.nowCal, viewModel.goalCal * 5)
                        progressValue = CGFloat(viewModel.nowCal) / CGFloat(viewModel.goalCal)
                    } label: {
                        Text("1kcal")
                            .bold()
                            .padding()
                            .frame(width: 160, height: 80)
                            .foregroundColor(Color.white)
                            .background(Color(.orange))
                            .cornerRadius(10)
                    }
                }
                .padding(.bottom, 5.0)
                
                HStack {
                    Button {
                        viewModel.nowCal -= 10
                        if viewModel.nowCal < 0 {
                            viewModel.nowCal = 0
                        }
                        progressValue = CGFloat(viewModel.nowCal) / CGFloat(viewModel.goalCal)
                    } label: {
                        Text("-10kcal")
                            .bold()
                            .padding()
                            .frame(width: 160, height: 80)
                            .foregroundColor(Color.white)
                            .background(Color(.orange))
                            .cornerRadius(10)
                    }
                    
                    Button {
                        viewModel.nowCal += 10
                        viewModel.nowCal = min(viewModel.nowCal, viewModel.goalCal * 5)
                        progressValue = CGFloat(viewModel.nowCal) / CGFloat(viewModel.goalCal)
                    } label: {
                        Text("10kcal")
                            .bold()
                            .padding()
                            .frame(width: 160, height: 80)
                            .foregroundColor(Color.white)
                            .background(Color(.orange))
                            .cornerRadius(10)
                    }
                }
                .padding(.bottom, 5.0)
                
                HStack {
                    Button {
                        viewModel.nowCal -= 50
                        if viewModel.nowCal < 0 {
                            viewModel.nowCal = 0
                        }
                        progressValue = CGFloat(viewModel.nowCal) / CGFloat(viewModel.goalCal)
                    } label: {
                        Text("-50kcal")
                            .bold()
                            .padding()
                            .frame(width: 160, height: 80)
                            .foregroundColor(Color.white)
                            .background(Color(.orange))
                            .cornerRadius(10)
                    }
                    
                    Button {
                        viewModel.nowCal += 50
                        viewModel.nowCal = min(viewModel.nowCal, viewModel.goalCal * 5)
                        progressValue = CGFloat(viewModel.nowCal) / CGFloat(viewModel.goalCal)
                    } label: {
                        Text("50kcal")
                            .bold()
                            .padding()
                            .frame(width: 160, height: 80)
                            .foregroundColor(Color.white)
                            .background(Color(.orange))
                            .cornerRadius(10)
                    }
                }
                .padding(.bottom, 5.0)
                
                HStack {
                    Button {
                        viewModel.nowCal -= 100
                        if viewModel.nowCal < 0 {
                            viewModel.nowCal = 0
                        }
                        progressValue = CGFloat(viewModel.nowCal) / CGFloat(viewModel.goalCal)
                    } label: {
                        Text("-100kcal")
                            .bold()
                            .padding()
                            .frame(width: 160, height: 80)
                            .foregroundColor(Color.white)
                            .background(Color(.orange))
                            .cornerRadius(10)
                    }
                    
                    Button {
                        viewModel.nowCal += 100
                        viewModel.nowCal = min(viewModel.nowCal, viewModel.goalCal * 5)
                        progressValue = CGFloat(viewModel.nowCal) / CGFloat(viewModel.goalCal)
                    } label: {
                        Text("100kcal")
                            .bold()
                            .padding()
                            .frame(width: 160, height: 80)
                            .foregroundColor(Color.white)
                            .background(Color(.orange))
                            .cornerRadius(10)
                    }
                }
                .padding(.bottom, 5.0)
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .frame(maxHeight: .infinity)
        .onAppear {
            newMaxValue = Double(viewModel.goalCal)
        }
    }
}

// プログレスバーを使うビュー

struct CalView_Pre: PreviewProvider {
    static var previews: some View {
        CalView()
    }
}
