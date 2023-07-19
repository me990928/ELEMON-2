//
//  AddView.swift
//  U22Prot0601
//
//  Created by 中島瑠斗 on 2023/06/13.
//


import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentation
    @ObservedObject var viewModel = ListViewModel.shared
    
    var dis: Bool {
        return !viewModel.title.isEmpty
      }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("タイトル")) {
                    TextField("", text: $viewModel.title)
                }
                Section(header: Text("デスクリプション")) {
                    TextField("", text: $viewModel.desc)
                }
            }
            .navigationTitle(viewModel.updatingTodo == nil ? "ToDoを追加" : "ToDoを更新")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        if (viewModel.updatingTodo == nil) {
                            viewModel.addTodo()
                        } else {
                            viewModel.updateTodo()
                        }
                        viewModel.isShowAddView.toggle()
                    }) {
                        Text("完了")
                    }.disabled(!dis)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                    }) {
                        Text("キャンセル")
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
