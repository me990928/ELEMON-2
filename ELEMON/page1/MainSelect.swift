//
//  MainSelect.swift
//  
//
//  Created by Yuya Hirose on 2023/06/17.
//

import SwiftUI

struct MainSelect: View {
    
    @ObservedObject var page1Model: Page1ViewModel
    
    @State var i:Int = 0
    @State var r:Int = 0
    @State var h:Int = 0
    @State var o:Int = 0
    
    var body: some View {
//            GeometryReader { val in
        VStack{
            Spacer().frame(height: 30)
            HStack {
                NavigationLink(destination: self.naviSelect(i: i)) {
                    //                            item1()
                    self.viewSelect(i: page1Model.topIcon(), c: "Bule")
                }
                NavigationLink(destination: self.naviSelect(i: r)) {
                    self.viewSelect(i: r, c: "Yello")
                }
            }.frame(width: 350)
            HStack {
                NavigationLink(destination: self.naviSelect(i: h)) {
                    self.viewSelect(i: h, c: "Green")
                }
                NavigationLink(destination: self.naviSelect(i: o)) {
                    self.viewSelect(i: o, c: "Purpul")
                }
            }.frame(width: 350)
            
            SubSelector(page1Model: Page1ViewModel()).padding(.top)
        }.onDisappear{
            r = self.page1Model.mainViewReader(i: 0)
            h = self.page1Model.mainViewReader(i: 1)
            o = self.page1Model.mainViewReader(i: 2)
        }.foregroundColor(.white)
            .onAppear(){
                r = self.page1Model.mainViewReader(i: 0)
                h = self.page1Model.mainViewReader(i: 1)
                o = self.page1Model.mainViewReader(i: 2)
            }.foregroundColor(.white)
    }
    
    
    
    func viewSelect(i:Int,c:String) ->AnyView{
        switch i {
        case 0:
            return AnyView(item1(color: c))
        case 1:
            return AnyView(item2(color: c))
        case 2:
            return AnyView(item5(color: c))
        case 3:
            return AnyView(item6(color: c))
        case 4:
            return AnyView(item8(color: c))
        case 5:
            return AnyView(item7(color: c))
        case 6:
            return AnyView(item4(color: c))
        case 7:
            return AnyView(item3(color: c))
        default:
            return AnyView(item1(color: c))
        }
    }
    
    
    func naviSelect(i:Int) ->AnyView{
        switch i {
        case 0:
            return AnyView(BedSampleView())
        case 1:
            return AnyView(walkSampleView())
        case 2:
            return AnyView(hartsSampleView())
        case 3:
            return AnyView(CalView())
        case 4:
            return AnyView(activitySampleView())
        case 5:
            return AnyView(WaterView())
        case 6:
            return AnyView(BodyView())
        case 7:
            return AnyView(MindFullnessSampleView())
        default:
            return AnyView(item1(color: "Yello"))
        }
    }
}

struct MainSelect_Previews: PreviewProvider {
    static var previews: some View {
        MainSelect(page1Model: Page1ViewModel())
    }
}

