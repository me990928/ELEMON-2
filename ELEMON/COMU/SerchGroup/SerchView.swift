//
//  SerchView.swift
//  ELEMON
//
//  Created by Yuya Hirose on 2023/08/31.
//

import SwiftUI
import RealmSwift

struct serchResult: View{
    
    let hostId: String
    let owner: String
    let title: String
    let context: String
    
    @State var data = [Groups]()
    
    @State var registGroup: Bool = false
    
    var body: some View{
        Button {
            registGroup.toggle()
        } label: {
            VStack {
                HStack{
                    Text(title).font(.title2).foregroundColor(Color(.label))
                    Spacer()
                }
                HStack{
                    Text(context).font(.body).foregroundColor(.gray)
                    Spacer()
                }
            }
        }
        .alert("入室しますか？",isPresented: $registGroup) {
            Button("Yes"){
                
                let groups = Groups(hostId: hostId, name: title, context: context, owner: owner)
                ComuRealmModel().addGroup(data: groups)
            }
            Button("No"){}
        }
    }
}

struct SerchView: View {
    
    @EnvironmentObject var css: ColorThema
    
    @ObservedObject var searchVM = ComuViewModel()
    
    @Binding var text:String
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("検索結果").font(.title).padding(.vertical, 20)
                Spacer()
            }.background(Color(css.accent))
            
            VStack{
                List(searchVM.groups, id: \.self){ item in
                    serchResult(hostId: item.hostId, owner: item.owner, title: item.name, context: item.context).listRowBackground(Color.clear)
                }.scrollContentBackground(.hidden).listStyle(.grouped)
            }
            
            Spacer()
        }.onAppear(){
            searchVM.searchGroup(inputText: text) { result in
                DispatchQueue.main.async {
                    searchVM.groups = result
                }
            }
        }
    }
}
