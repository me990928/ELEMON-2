//
//  TopPage.swift
//  ELEMON
//
//  Created by Yuya Hirose on 2023/08/30.
//

import SwiftUI
import RealmSwift

struct ListTemplate:View{
    
    let id: String
    let title: String
    let context: String
    let checked: Bool
    
    var body: some View {
        NavigationLink{
            ChatView().navigationTitle(title)
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
    
    @ObservedResults(GroupObj.self) var groupObj
    
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
                    
                    Spacer()

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
                    
                    EditButton().foregroundColor(Color(css.accent))
                }.padding(.top)
                
                List{
                    ForEach((groupObj.freeze()).reversed()){data in
                        ListTemplate(id: data.hostId, title: data.name, context: data.context, checked: data.checked).listRowBackground(Color.clear)
                    }.onDelete { IndexSet in
                        $groupObj.remove(atOffsets: IndexSet)
                    }
                }.scrollContentBackground(.hidden).listStyle(.grouped).refreshable {
                    
                }
                
                Spacer()
            }.padding().gesture(self.gesture)
        }.onAppear(){
            
        }
    }
}

struct TopPage_Previews: PreviewProvider {
    static var previews: some View {
        TopPage().environmentObject(ColorThema())
    }
}
