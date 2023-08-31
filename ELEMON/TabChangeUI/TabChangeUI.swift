//
//  ContentView.swift
//  TabChangeUI
//
//  Created by Yuya Hirose on 2023/07/05.
//

import SwiftUI

struct textView: View {
    @State var text: String
    
    var body: some View{
        VStack{
            Text(text)
            Spacer()
        }
    }
}

struct page1:View{
    var body: some View{
        VStack{
            
            ScrollView(.vertical,showsIndicators: false){
                HStack{Spacer()}
                Group {
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                }
                Group {
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                }
                Group {
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                    textView(text: "azarasi")
                }
                
            }
        }
    }
}

struct page2:View{
    var body: some View{
        VStack{
            
            ScrollView(.vertical,showsIndicators: false){
                HStack{Spacer()}
                Group {
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                }
                Group {
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                }
                Group {
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                    textView(text: "kazaamma")
                }
                
            }
        }
    }
}

struct splitView: View {
    var body: some View{
        GeometryReader { geo in
            HStack(spacing: 0){
                ContentView123421().frame(width: geo.size.width)
//            Divider()
                SelfManagementBarView().frame(width: geo.size.width).background(.gray)
            }
        }
    }
}


struct TabChangeUI: View {
    
    @State var yOf:CGFloat = 0
    @State var xOf:CGFloat = 0
    @State var xs:CGFloat = 0
    @State var xOffsetflag:Bool = false
    @EnvironmentObject var tabModel:TabModel
    @EnvironmentObject var css:ColorThema
    
    var body: some View {
            VStack{
                ZStack{
                    VStack{
                            Spacer().frame(height: yOf*0.035)
                            splitView().offset(x: tabModel.xOfsetVal).animation(.default, value: tabModel.xOfsetVal)
                    }.gesture(DragGesture()
                        .onEnded({ val in
                            print(val.translation.width)
                            if val.startLocation.x > val.predictedEndLocation.x && val.translation.width < -(tabModel.xOfsetSt * 0.5) {
                                tabModel.xOfsetVal = -tabModel.xOfsetSt
                                self.tabModel.xOfset = true
                            }
                            if(val.startLocation.x < val.predictedEndLocation.x && val.translation.width > tabModel.xOfsetSt * 0.5){
                                tabModel.xOfsetVal = 0
                                self.tabModel.xOfset = false
                            }
                        })
                    )
                    
                    GeometryReader { geoVal in
                        TabUIView(xOffsetflag: self.xOffsetflag).onAppear(){
                            yOf = geoVal.size.height
                            tabModel.xOfsetVal = 0
                            tabModel.xOfsetSt = geoVal.size.width
                        }
                    }
            }
        }
    }
}

struct ContentView_Previews34: PreviewProvider {
    static var previews: some View {
        TabChangeUI().environmentObject(TabModel()).environmentObject(FireAuthModel()).environmentObject(HealthSleep()).environmentObject(ColorThema())
    }
}
