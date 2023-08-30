//
//  TopPage.swift
//  ELEMON
//
//  Created by Yuya Hirose on 2023/08/30.
//

import SwiftUI

struct ListTemplate:View{
    
    let title: String
    let context: String
    
    var body: some View {
        NavigationLink{
            Text("Sample")
        } label:{
            VStack{
                HStack {
                    Text(self.title).font(.title2)
                    Spacer()
                }
                HStack {
                    Text(self.context).foregroundColor(.gray)
                    Spacer()
                }
            }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct TopPage: View {
    @State var text: String = ""
    @State var registSheet: Bool = false
    
    @EnvironmentObject var css: ColorThema
    
    @FocusState var focus:Bool
    
    var gesture: some Gesture {
        DragGesture()
            .onChanged { val in
                if val.translation.height != 0 {
                    self.focus = false
                }
            }
    }
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack {
                    TextField("ルーム名", text: $text).textFieldStyle(.roundedBorder).focused($focus)
                    Button {
                    } label: {
                        Image(systemName: "magnifyingglass").foregroundColor(Color(css.accent))
                    }

                }
                HStack{
                    Text("トークルーム").foregroundColor(.gray)
                    Button {
                        self.registSheet.toggle()
                    } label: {
                        Image(systemName: "plus").foregroundColor(Color(css.accent))
                    }.buttonStyle(.automatic).sheet(isPresented: $registSheet) {
                        CreateGroup(registSheet: $registSheet, comuVM: ComuViewModel()).ignoresSafeArea(.all)
                    }
                    Spacer()
                }.padding(.top)
                
                List{
                    ListTemplate(title: "ルーム名", context: "ルームの説明")
                }.scrollContentBackground(.hidden).listStyle(.grouped)
                
                Spacer()
            }.padding().gesture(self.gesture)
        }
    }
}

struct TopPage_Previews: PreviewProvider {
    static var previews: some View {
        TopPage().environmentObject(ColorThema())
    }
}
