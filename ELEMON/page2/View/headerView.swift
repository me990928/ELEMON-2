//
//  headerView.swift
//  ELEMON
//
//  Created by 中島瑠斗 on 2023/08/13.
//
import SwiftUI

struct headerView: View {
    @ObservedObject var viewModel = ListViewModel.shared
    var body: some View {
        HStack {
            Text("完了")
            Spacer()
            Button("完了済みを消去") {
                // ボタンのアクション
                viewModel.hiddenTodo()
            }
        }
    }
}
struct headerView_Previews: PreviewProvider {
    static var previews: some View {
        headerView()
    }
}

