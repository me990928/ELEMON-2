//
//  TabUIView.swift
//  TabChangeUI
//
//  Created by Yuya Hirose on 2023/07/05.
//

import SwiftUI

struct TabUIView: View {
    
    @State var xOffset:CGFloat = 0
    @State var xOffsetflag:Bool
    
    @AppStorage ("css") var cflag = 0
    
    @EnvironmentObject var tabModel:TabModel
    @EnvironmentObject var css: ColorThema
    
    var body: some View {
        
        GeometryReader { geoVal in
            VStack(spacing: 0) {
                    HStack{
                        Spacer().frame(width: geoVal.size.width / 5)
                        VStack(){
                            Button {
                                print("ELEMON")
                                print(geoVal.size.height)
                                tabModel.xOfset = false
                            } label: {
                                Text("ELEMON").font(.title2)
                            }
                        }
                        Spacer()
                        VStack(){
//                            Spacer().frame(height: 40)
                            Button {
                                print("Health")
                                tabModel.xOfset = true
                            } label: {
                                Text("Health").font(.title2)
                            }
                        }
                        Spacer().frame(width: geoVal.size.width / 5)
                    }.foregroundColor(Color(self.css.text))
                    .background(Color(self.css.tab))
                        .frame(width: geoVal.size.width)
//                        .ignoresSafeArea()
                HStack{
//                    Spacer().frame(width: xOffset).animation(.default, value: xOffset)
                    Text("").frame(width: 100, height: 3).background(.pink).offset(x: xOffset).animation(.default, value: xOffset)
                    Spacer()
                }.onAppear(){
                    xOffset = geoVal.size.width / 5.5
                    self.css.regist(i: cflag)
                }
            }.background(.gray)
                .onChange(of: self.tabModel.xOfset) { _ in
                    if self.tabModel.xOfset {
                        xOffset = geoVal.size.width / 1.71
                        tabModel.xOfsetVal = -tabModel.xOfsetSt
                    }else {
                        xOffset = geoVal.size.width / 5.5
                        tabModel.xOfsetVal = 0
                    }
                }
                .onChange(of: self.cflag) { newValue in
                    self.css.regist(i: cflag)
                }
        }
    }
}

struct TabUIView_Previews: PreviewProvider {
    static var previews: some View {
        TabUIView(xOffsetflag: false).environmentObject(TabModel()).environmentObject(ColorThema())
    }
}
