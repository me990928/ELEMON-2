//
//  ContentView.swift
//  waterPage
//
//  Created by 中島瑠斗 on 2023/05/11.
//

import SwiftUI


// プログレスバーのビュー
struct WaterView: View {
    @ObservedObject var viewModel = ActivityModel()
    @State var sheetFlag: Bool = false
    
    let newMaxValues = Array(500...5000)
    @State var newMaxValue:Double = 500
    
    var body: some View {
        @State var progressValue:CGFloat = CGFloat(viewModel.nowWater)/CGFloat(viewModel.goalWater)

        ScrollView(.vertical){
            VStack{
                HStack{
                    Image(systemName: "drop").font(.title).padding().foregroundColor(.primary)
                    Text("水分")
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
                    .foregroundColor(Color(.systemMint))
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
                                .foregroundColor(Color(.systemMint))
                                
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
                                .foregroundColor(Color(.systemMint))
                            }
                            .padding(.horizontal)
                            
                            Button(action: {
                                viewModel.goalWater = Int(newMaxValue.rounded())
                                progressValue = CGFloat(viewModel.nowWater) / CGFloat(viewModel.goalWater)
                                sheetFlag = false
                            }, label: {
                                Text("適用")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color(.systemMint))
                                    .cornerRadius(10)
                            })
                            .padding()
                            
                            Button(action: {
                                newMaxValue = Double(viewModel.goalWater)
                                sheetFlag = false
                            }, label: {
                                Text("キャンセル")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color(.systemMint))
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
                            Color(red: 0/255, green: 140/255, blue: 200/255),
                            Color(red: 0/255, green: 0/255, blue: 255/255)
                            
                            
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
                            .foregroundColor(.blue)
                        
                        // 進捗を示す円
                        Circle()
                        // 始点/終点を指定して円を描画する
                        // 始点/終点には0.0-1.0の範囲に正規化した値を指定する
                            .trim(from: 0.0, to: min(progressValue, 1.0))
                        // 線の端の形状などを指定
                            .stroke(purpleAngularGradient,style: StrokeStyle(lineWidth: 24, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color(.systemMint))
                        // デフォルトの原点は時計の12時の位置ではないので回転させる
                            .rotationEffect(Angle(degrees: 270.0))
                        
                        VStack{
                            Text("\(viewModel.goalWaterString)")
                                .foregroundColor(Color.gray)
                            // 進捗率のテキスト
                            Text(String(format: "%.0f%%", min(progressValue, 3.0) * 100.0))
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(Color(.label))
                            Text("\(viewModel.nowWater)ml/\(viewModel.goalWater)ml")
                                .foregroundColor(Color.gray)
                            
                        }
                        
                    }
                    .padding()
                    
                    
                }//body
                .frame(width: 250,height: 250)
                .padding(.bottom, 40.0)
                HStack {
                    Button {
                        if viewModel.nowWater > 0 {
                            viewModel.nowWater += 10
                            progressValue = CGFloat(viewModel.nowWater) / CGFloat(viewModel.goalWater)
                        }
                    } label: {
                        Text("10ml")
                            .bold()
                            .padding()
                            .frame(width: 160, height: 80)
                            .foregroundColor(Color.white)
                            .background(Color(.systemMint))
                            .cornerRadius(10)
                    }
                    
                    Button {
                        viewModel.nowWater += 50
                        viewModel.nowWater = min(viewModel.nowWater, viewModel.goalWater * 5)
                        progressValue = CGFloat(viewModel.nowWater) / CGFloat(viewModel.goalWater)
                    } label: {
                        Text("50ml")
                            .bold()
                            .padding()
                            .frame(width: 160, height: 80)
                            .foregroundColor(Color.white)
                            .background(Color(.systemMint))
                            .cornerRadius(10)
                    }
                }
                .padding(.bottom, 5.0)
                
                HStack {
                    Button {
                        viewModel.nowWater += 100
                        if viewModel.nowWater < 0 {
                            viewModel.nowWater = 0
                        }
                        progressValue = CGFloat(viewModel.nowWater) / CGFloat(viewModel.goalWater)
                    } label: {
                        Text("100ml")
                            .bold()
                            .padding()
                            .frame(width: 160, height: 80)
                            .foregroundColor(Color.white)
                            .background(Color(.systemMint))
                            .cornerRadius(10)
                    }
                    
                    Button {
                        viewModel.nowWater += 150
                        viewModel.nowWater = min(viewModel.nowWater, viewModel.goalWater * 5)
                        progressValue = CGFloat(viewModel.nowWater) / CGFloat(viewModel.goalWater)
                    } label: {
                        Text("150ml")
                            .bold()
                            .padding()
                            .frame(width: 160, height: 80)
                            .foregroundColor(Color.white)
                            .background(Color(.systemMint))
                            .cornerRadius(10)
                    }
                }
                .padding(.bottom, 5.0)
                
                HStack {
                    Button {
                        viewModel.nowWater += 300
                        if viewModel.nowWater < 0 {
                            viewModel.nowWater = 0
                        }
                        progressValue = CGFloat(viewModel.nowWater) / CGFloat(viewModel.goalWater)
                    } label: {
                        Text("300ml")
                            .bold()
                            .padding()
                            .frame(width: 160, height: 80)
                            .foregroundColor(Color.white)
                            .background(Color(.systemMint))
                            .cornerRadius(10)
                    }
                    
                    Button {
                        viewModel.nowWater += 500
                        viewModel.nowWater = min(viewModel.nowWater, viewModel.goalWater * 5)
                        progressValue = CGFloat(viewModel.nowWater) / CGFloat(viewModel.goalWater)
                    } label: {
                        Text("500ml")
                            .bold()
                            .padding()
                            .frame(width: 160, height: 80)
                            .foregroundColor(Color.white)
                            .background(Color(.systemMint))
                            .cornerRadius(10)
                    }
                }
                .padding(.bottom, 5.0)
                
                HStack {
                    Button {
                        viewModel.nowWater += 1000
                        if viewModel.nowWater < 0 {
                            viewModel.nowWater = 0
                        }
                        progressValue = CGFloat(viewModel.nowWater) / CGFloat(viewModel.goalWater)
                    } label: {
                        Text("1000ml")
                            .bold()
                            .padding()
                            .frame(width: 160, height: 80)
                            .foregroundColor(Color.white)
                            .background(Color(.systemMint))
                            .cornerRadius(10)
                    }
                    
                    Button {
                        viewModel.nowWater = 0
                        viewModel.nowWater = min(viewModel.nowWater, viewModel.goalWater * 5)
                        progressValue = CGFloat(viewModel.nowWater) / CGFloat(viewModel.goalWater)
                    } label: {
                        Text("リセット")
                            .bold()
                            .padding()
                            .frame(width: 160, height: 80)
                            .foregroundColor(Color.white)
                            .background(Color(.systemMint))
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
            newMaxValue = Double(viewModel.goalWater)
        }
    }
}

// プログレスバーを使うビュー

struct WaterView_Pre: PreviewProvider {
    static var previews: some View {
        WaterView()
    }
}
