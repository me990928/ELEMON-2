//
//  ContentView.swift
//  bodyPage
//
//  Created by 中島瑠斗 on 2023/05/16.
//

import SwiftUI
import UIKit

struct BodyView: View {
    
    func  bmi(wei:Float,hei:Float) -> String {
        let BMI = wei / ((hei/100) * (hei/100))
        return String(BMI)
    }
    
    let namedFonts:[String] = [
        "体温",
        "体脂肪体重",
        "体脂肪率",
        "手首皮膚温度"
    ]
    
    @State var sheet:Bool = false
    @State var flag1:Bool = false
    
    @ObservedObject var model = ActivityModel()
    
    @EnvironmentObject var healthSleep: HealthSleep
//    @State var status: HKAuthorizationStatus = .notDetermined
    @AppStorage("weight") var weight = 50.0
    @AppStorage("height") var height = 160.0
    @State var isShowingAlert = false
    @State var alertTitle = ""
    
    @State var taiz:String = ""
    
    
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Image(systemName: "figure.walk").font(.title).padding().foregroundColor(.primary)
                    Text("身体測定値")
                        .font(.title).foregroundColor(.primary)
                    Spacer()
                    Button("+"){
                        flag1 = true
                    }.padding().font(.title).foregroundColor(Color(.label))
                        .sheet(isPresented: $flag1) {
                            VStack{
                                HStack {
                                    Text("体重")
                                    Spacer()
                                }
                                //TextField("", text: $weight)
                                HStack {
                                    Text("身長")
                                    Spacer()
                                }
                                //TextField("身長", text: $height)
                                    .keyboardType(.numberPad)
                                
                                Button("追加"){
                                    
                                }
                            }.padding().textFieldStyle(.roundedBorder).foregroundColor(Color(.label))
                        }
                }
                
                GroupBox{
                    VStack{
                        HStack {
                            Text("体重").font(.title2).foregroundColor(.primary)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Text(String(weight)+"kg").font(.largeTitle).foregroundColor(.primary)
                        }
                    }
                }.padding(.horizontal)
                GroupBox{
                    VStack{
                        HStack {
                            Text("身長").font(.title2).foregroundColor(.primary)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Text(String(height)+"cm").font(.largeTitle).foregroundColor(.primary)
                        }
                    }
                }.padding(.horizontal)
                GroupBox {
                    VStack{
                        HStack {
                            Text("BMI").font(.title2).foregroundColor(.primary)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Text(self.bmi(wei: Float(weight) , hei: Float(height) )).font(.largeTitle).foregroundColor(Color(.label))
                        }
                        
                    }
                }.padding(.horizontal)
                Spacer()
                List{
//
//                    NavigationLink(destination: bodyTemperatureView()){
//                        HStack{
//                            Text("体温")
//                                .padding(.leading, 40)
//                            Spacer()
//                            Image(systemName: "chevron.right")
//                        }
//                        .frame(width: 350, height: 35)
//
//
//                    }//nacigationLink
//                    .listRowBackground(Color(UIColor.systemGray5))
//                    NavigationLink(destination: leanBodyMassView()){
//                        HStack{
//                            Text("除脂肪体重")
//                                .padding(.leading, 40)
//                            Spacer()
//                            Image(systemName: "chevron.right")
//                        }
//                        .frame(width: 350, height: 35)
//
//                    }//nacigationLink
//                    .listRowBackground(Color(UIColor.systemGray5))
//                    NavigationLink(destination: bodyFatPercentageView()){
//                        HStack{
//                            Text("体脂肪率")
//                                .padding(.leading, 40)
//                            Spacer()
//                            Image(systemName: "chevron.right")
//                        }
//                        .frame(width: 350, height: 35)
//
//                    }//nacigationLink
//                    .listRowBackground(Color(UIColor.systemGray5))
//
//                    NavigationLink(destination: wristTemperatureView()){
//                        HStack{
//                            Text("手首皮膚温度")
//                                .padding(.leading, 40)
//                            Spacer()
//                            Image(systemName: "chevron.right")
//                        }
//                        .frame(width: 350, height: 35)
//
//                    }//nacigationLink
//                    .listRowBackground(Color(UIColor.systemGray5))
                    
                    ForEach(namedFonts,id: \.self) { namedFont in
                        Button(namedFont){
                            self.sheet.toggle()
                        }.listRowBackground(Color(UIColor.systemGray5))
                            .sheet(isPresented: $sheet) {
                                
                                GroupBox {
                                    VStack{
                                        HStack {
                                            Text("今週の\(namedFont)").font(.title2).foregroundColor(.primary)
                                            Spacer()
                                        }
                                        MindFullNess().frame(height: 180).padding()
                                    }.presentationDetents([.medium])
                                }.padding()
                            }
                    }
                }//list
                
                .scrollContentBackground(.hidden)
//                .background(Color.white)
                .foregroundColor(Color(.label))
                
                
            }//navigationView
        }
    }
    
    
    
    struct BodyView_Previews: PreviewProvider {
        static var previews: some View {
            BodyView()
        }
    }
}
