//
//  InquiryFormView.swift
//  page4
//
//  Created by Yuya Hirose on 2023/05/31.
//

import SwiftUI

struct InquiryFormView: View {
    @State private var showingMailSheet = false
    var body: some View {
        VStack{
            GroupBox {
                HStack {
                    Text("よくある質問").font(.title2)
                    Spacer()
                }
                
                ScrollView(){
                    HStack {
                        QandaView().foregroundColor(.black).padding()
                        Spacer()
                    }
                }.background(Color(.white)).cornerRadius(10).frame(height: 300)
            }.padding(.bottom, 20)
            
            GroupBox {
                HStack {
                    Text("お問い合わせ").font(.title2)
                    Spacer()
                }
                
                Text("ヘルプで解決できない場合はお気軽にお問い合わせください。").padding(.top, 10)
                
                Button("お問い合わせ"){
                    self.showingMailSheet.toggle()
                }.buttonStyle(.borderedProminent).padding()
                    .sheet(isPresented: $showingMailSheet) {
//                        Text("メールピッカー")
                        VStack{
                            HStack{
                                Button("キャンセル"){
                                    self.showingMailSheet.toggle()
                                }
                                Spacer()
                            }.padding(.bottom,10)
                            
                            HStack{
                                Text("お問い合わせ").font(.title2)
                                Spacer()
                            }
                            
                            HStack{
                                Text("宛先：").foregroundColor(.gray)
                                Spacer()
                            }.padding(.top)
                            Divider()
                            HStack{
                                Text("件名：").foregroundColor(.gray)
                                Spacer()
                            }.padding(.top)
                            Divider()
                            HStack{
                                Text("本文").foregroundColor(.gray)
                                Spacer()
                            }.padding(.top)
                            
                            Spacer()
                        }.padding()
                    }
            }
            Spacer()
        }.padding()
    }
}

struct InquiryFormView_Previews: PreviewProvider {
    static var previews: some View {
        InquiryFormView()
    }
}
