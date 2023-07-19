//
//  CharView.swift
//  game
//
//  Created by 広瀬友哉 on 2023/06/27.
//

import SwiftUI

struct CharView: View {
    var body: some View {
        VStack {
            Image("elemonChar2").resizable()
        }
    }
}

struct CharView_Previews: PreviewProvider {
    static var previews: some View {
        CharView().environmentObject(FirestoreModel()).environmentObject(FireAuthModel()).environmentObject(HealthSleep()).environmentObject(TabModel())
    }
}
