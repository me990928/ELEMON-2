//
//  ProgressView.swift
//  ELEMON
//
//  Created by Yuya Hirose on 2023/08/25.
//

import SwiftUI

struct ProgressViews: View {
    @State var text: String
    var body: some View {
        VStack{
            ZStack{
                Spacer().frame(maxWidth: .infinity, maxHeight: .infinity).background(.ultraThinMaterial).cornerRadius(20)
                ProgressView(self.text)
            }
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressViews(text: "test")
    }
}
