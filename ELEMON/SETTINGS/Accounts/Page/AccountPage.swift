//
//  ContentView.swift
//  Tab
//
//  Created by Yuya Hirose on 2023/08/16.
//

import SwiftUI

enum TabItems: String, CaseIterable {
    case Login
    case Regist
    
    var imageName: String {
        switch self {
        case .Login: return "door.right.hand.closed"
        case .Regist: return "square.and.pencil"
        }
    }

}

struct AccountPage: View {
    
    @State private var tabMidX: CGFloat = 0
    @State private var tabSize: CGFloat = 0
    @State private var selected: TabItems = .Login
    
    @State private var viewOffX: CGFloat = 0
    
    @State var isDisable: Bool = true
    
    @EnvironmentObject var css: ColorThema
    
    var body: some View {
        GeometryReader { bodyGeo in
            
            VStack(spacing: 0) {
                HStack(spacing: 0){
                    GeometryReader { Item1 in
                        Button {
                            selected = .Login
                            tabSize = bodyGeo.size.width / 2
                            viewOffX = 0
//                            withAnimation (
//                                .interactiveSpring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5)
//                            ){
//                                tabMidX = Item1.frame(in: .global).midX
//                            }
                            tabMidX = Item1.frame(in: .global).midX
                        } label: {
                            Text(TabItems.Login.rawValue.uppercased()).fontWeight(.heavy).foregroundColor(.white)
                        }
                        .frame(width: Item1.size.width, height: Item1.size.height)
                        .onAppear{
                            if selected == TabItems.allCases.first {
                                tabMidX = Item1.frame(in: .global).midX
//                                tabSize = bodyGeo.size.width / 2
                            }
                            
                        }
                    }.frame(width: bodyGeo.size.width / 2, height: 100)
                
                
                
                    GeometryReader { Item2 in
                        Button {
                            selected = .Login
                            viewOffX = -bodyGeo.size.width
                            tabSize = bodyGeo.size.width / 2
//                            withAnimation (
//                                .interactiveSpring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5)
//                            ){
//                                tabMidX = Item2.frame(in: .global).midX
//                            }
                            tabMidX = Item2.frame(in: .global).midX
                        } label: {
                            Text(TabItems.Regist.rawValue.uppercased()).fontWeight(.heavy).foregroundColor(.white)
                        }
                        .frame(width: Item2.size.width, height: Item2.size.height)
                        .onAppear{
                            if selected == TabItems.allCases.first {
                                tabMidX = Item2.frame(in: .global).midX
                            }
                        }
                    }.frame(width: bodyGeo.size.width / 2, height: 100)
                    
                    
                    
                }.frame(height: 70).background(Color(self.css.accent)).ignoresSafeArea(edges: .bottom)
                .zIndex(1)
            
                HStack(spacing: 0){
                    Spacer().frame(width: tabSize,height: 10).background(.orange).position(x: tabMidX).animation(.linear, value: tabMidX)
                }.frame(height: 0)
                
                GeometryReader { GeometryProxy in
                    HStack {
                        LoginView().frame(width: GeometryProxy.size.width).padding(.top).ignoresSafeArea(.all)
                        RegistView().frame(width: GeometryProxy.size.width).ignoresSafeArea(.all)
                    }.frame(width: GeometryProxy.size.width * 2)
                        .offset(x: viewOffX).animation(.default, value: viewOffX)
                }
                
                Button("あとで消すシートダウン"){
                    isDisable.toggle()
                }
                
            }.onAppear(){
                tabSize = bodyGeo.size.width / 2
            }
        }.interactiveDismissDisabled(isDisable)
    }
}



struct AccountPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountPage().environmentObject(ColorThema())
    }
}
