//
//  SubSelector.swift
//  ELEMON
//
//  Created by Yuya Hirose on 2023/06/17.
//

import SwiftUI

struct SubSelector: View {
    
    @ObservedObject var page1Model: Page1ViewModel
    
    var body: some View {
        VStack{
            NavigationLink(destination: BedSampleView().onAppear(){page1Model.counter(i: 0)}){
                HStack{
                    Image(systemName: "bed.double")
                        .padding(.leading, 30)
                    Text("睡眠")
                        .padding(.leading, 10)
                    Spacer()
                }
                .frame(width: 350, height: 50)
                .background(.pink)
                .cornerRadius(30)
            }
            
            
            NavigationLink(destination: walkSampleView().onAppear(){page1Model.counter(i: 1)}){
                HStack{
                    Image(systemName: "figure.walk")
                        .padding(.leading, 30)
                    Text("歩数")
                        .padding(.leading, 10)
                    Spacer()
                }
                .frame(width: 350, height: 50)
                .background(.pink)
                .cornerRadius(30)
            }
            
            
            NavigationLink(destination: hartsSampleView().onAppear(){page1Model.counter(i: 2)}){
                HStack{
                    Image(systemName: "waveform.path.ecg")
                        .padding(.leading, 30)
                    Text("心拍数")
                        .padding(.leading, 10)
                    Spacer()
                }
                .frame(width: 350, height: 50)
                .background(.pink)
                .cornerRadius(30)
            }
            
            
            NavigationLink(destination: CalView().onAppear(){page1Model.counter(i: 3)}){
                HStack{
                    Image(systemName: "fork.knife")
                        .padding(.leading, 30)
                    Text("カロリー")
                        .padding(.leading, 10)
                    Spacer()
                }
                .frame(width: 350, height: 50)
                .background(.pink)
                .cornerRadius(30)
            }
            
            NavigationLink(destination: activitySampleView().onAppear(){page1Model.counter(i: 4)}){
                
                HStack{
                    Image(systemName: "flame")
                        .padding(.leading, 30)
                    Text("アクティビティ")
                        .padding(.leading, 10)
                    Spacer()
                }
                .frame(width: 350, height: 50)
                .background(.pink)
                .cornerRadius(30)
                
            }
            NavigationLink(destination: WaterView().onAppear(){page1Model.counter(i: 5)}){
                
                HStack{
                    Image(systemName: "drop")
                        .padding(.leading, 30)
                    Text("水分")
                        .padding(.leading, 10)
                    Spacer()
                }
                .frame(width: 350, height: 50)
                .background(.pink)
                .cornerRadius(30)
                
            }
            
            NavigationLink(destination: BodyView().onAppear(){page1Model.counter(i: 6)}){
                
                HStack{
                    Image(systemName: "figure.walk")
                        .padding(.leading, 30)
                    Text("身体測定値")
                        .padding(.leading, 10)
                    Spacer()
                }
                .frame(width: 350, height: 50)
                .background(.pink)
                .cornerRadius(30)
                
            }
            
            
            NavigationLink(destination: MindFullnessSampleView().onAppear(){page1Model.counter(i: 7)}){
                
                HStack{
                    Image(systemName: "figure.mind.and.body")
                        .padding(.leading, 30)
                    Text("マインドフルネス")
                        .padding(.leading, 10)
                    Spacer()
                }
                .frame(width: 350, height: 50)
                .background(.pink)
                .cornerRadius(30)
                
            }
            Spacer().frame(height: 60)
        }
    }
}

struct SubSelector_Previews: PreviewProvider {
    static var previews: some View {
        SubSelector(page1Model: Page1ViewModel())
    }
}
