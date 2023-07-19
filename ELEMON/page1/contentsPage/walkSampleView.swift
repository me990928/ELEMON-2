//
//  walkSampleView.swift
//  page1
//
//  Created by 広瀬友哉 on 2023/05/09.
//

import SwiftUI


struct walkSampleView: View {
    
    private var repository = HKRepository()
    private var health = Health(id: "stepCount", name: "Step Count", image: "👣")
    

    var items: [GridItem] {
      Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    }
    
    var body: some View {
        VStack{
           WalkDetailView(health: health, repository: repository)
            Spacer()
        }
    }
}

struct walkSampleView_Previews: PreviewProvider {
    static var previews: some View {
        walkSampleView()
    }
}

