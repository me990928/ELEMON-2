import SwiftUI
import UIKit
import Charts

struct BodyView: View {
    
    func  bmi(wei:Float,hei:Float) -> String {
        let BMI = wei / ((hei/100) * (hei/100))
        return String(BMI)
    }
    
    let namedFonts:[String] = [
        "体重",
        "BMI",
        "体脂肪率",
        "手首皮膚温度"
    ]
    
    @State var sheet:Bool = false
    @State var flag1:Bool = false
    
    @State var taiz:String = ""
    
    @AppStorage ("weight") var taizyu: String = "0"
    @AppStorage ("height") var height: String = "0"
    
    @AppStorage ("bodyCount") var c: Int = 0
    
    var Cm = ChartModel()
    
    @State var tx:String = ""
    
    //  グラフデータ
    @State var charta = [BodyCharts]()
    @State var bmich = [BodyCharts]()
    
    
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
                                TextField("", text: $taizyu)
                                HStack {
                                    Text("身長")
                                    Spacer()
                                }
                                TextField("身長", text: $height)
                                    .keyboardType(.numberPad)
                                
                                Button("追加"){
                                    print(self.taizyu)
                                    self.flag1 = false
                                    self.Cm.saveBMI(bmi: Double(self.bmi(wei: Float(taizyu) ?? 1.0, hei: Float(height) ?? 1.0)) ?? 0)
                                    self.Cm.saveWeight(wei: Double(Float(self.taizyu) ?? 0) )
                                    self.Cm.viewWei()
                                    self.Cm.viewBMI()
                                    self.charta = self.Cm.weightGRF
                                    self.bmich = self.Cm.BMIGRF
                                    
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
                            Text(String(taizyu)+"kg").font(.largeTitle).foregroundColor(.primary)
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
                            Text(height+"cm").font(.largeTitle).foregroundColor(.primary)
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
                            Text(self.bmi(wei: Float(taizyu) ?? 1.0, hei: Float(height) ?? 1.0)).font(.largeTitle).foregroundColor(Color(.label))
                        }
                        
                    }
                }.padding(.horizontal)
                Spacer()
//                List{
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
                    
                    GroupBox{
                        Text("今週の体重").font(.title2).padding(.bottom,10)
                        
                        VStack{
                            
                            
                            // グラフビュー
                            Chart(charta){ point in
                                BarMark(
                                    x: .value("title", point.title),
                                    y: .value("name", point.value)
                                ).foregroundStyle(.pink)
                            }
                        }
                    }.padding(.horizontal)
                    GroupBox{
                        VStack{
                            Text("今週のBMI").font(.title2).padding(.bottom,10)
                            
                            // グラフビュー
                            Chart(bmich){ point in
                                BarMark(
                                    x: .value("title", point.title),
                                    y: .value("name", point.value)
                                ).foregroundStyle(.pink)
                            }
                        }
                    }.padding(.horizontal)
//                }//list
                
//                .scrollContentBackground(.hidden)
//                .background(Color.white)
//                .foregroundColor(Color(.label))
                
                
            }//navigationView
            .onAppear(){
                if self.c < 1 {
                    self.Cm.initData()
                    self.c = 1
                    print("first")
                }
                self.Cm.viewWei()
                self.Cm.viewBMI()
                self.charta = self.Cm.weightGRF
                self.bmich = self.Cm.BMIGRF
                print("a:\(self.charta)")
            }
        }
    }
    
    
    
    struct BodyView_Previews: PreviewProvider {
        static var previews: some View {
            BodyView()
        }
    }
}
