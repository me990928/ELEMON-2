//
//  QandaView.swift
//  page4
//
//  Created by Yuya Hirose on 2023/05/31.
//

import SwiftUI

struct QandaView: View {
    var body: some View {
        VStack(alignment: .leading){
            Group {
                    Text("Q. よくある質問です。\nA. テストメッセージです。")
                    Divider()
                    Text("Q. よくある質問です。")
                    Text("A. テストメッセージです。")
                    Divider()
            }
            Group {
                    Text("Q. よくある質問です。\nA. テストメッセージです。")
                    Divider()
                    Text("Q. よくある質問です。")
                    Text("A. テストメッセージです。")
                    Divider()
            }
            Group {
                    Text("Q. よくある質問です。\nA. テストメッセージです。")
                    Divider()
                    Text("Q. よくある質問です。")
                    Text("A. テストメッセージです。")
            }
        }
    }
}

struct QandaView_Previews: PreviewProvider {
    static var previews: some View {
        QandaView()
    }
}
