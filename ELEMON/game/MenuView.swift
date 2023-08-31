//
//  MenuView.swift
//  game
//
//  Created by 広瀬友哉 on 2023/06/26.
//

import SwiftUI

struct MenuView: View {
    @State var xposi:CGFloat = 0
    @State var btnFlag:Bool = false
    @State var eatFlag:Bool = false
    @State var statFlag:Bool = false
    @State var drFlag:Bool = false
    @State var disDrFlag:Bool = false
    
    @EnvironmentObject var css:ColorThema
    
    @AppStorage ("css") var cflag = 0
    
    var char = CharModel()
    var body: some View {
        VStack{
            GeometryReader{ geoVal in
                    ZStack{
                        HStack {
                            HStack{
                                Text("").frame(width: 10)
                                HStack {
                                    Spacer().frame(width: 60,height: 70)
                                    Spacer()
                                    Button(action: {
                                        self.statFlag = true
                                        print(char.loadChar())
                                    }, label: {
                                        Image(systemName: "note.text").font(.title).foregroundColor(Color(self.css.text))
                                    }).frame(width: 55,height: 55).background(Color(self.css.accent)).cornerRadius(100).sheet(isPresented: $statFlag) {
                                        VStack{
                                            HStack{
                                                Spacer()
                                                
                                                Button("Close"){
                                                    self.statFlag = false
                                                }
                                                
                                            }.padding()
                                            StatusSheet(data: CharModel().err, charStatus: CharModel().err).scrollContentBackground(.hidden)
                                                .presentationDetents([.medium])
                                        }
                                    }
                                    
                                    
                                    
                                    Spacer()
                                    Button(action: {
                                        self.eatFlag = true
                                    }, label: {
                                        Image(systemName: "fork.knife").font(.title).foregroundColor(Color(self.css.text))
                                    }).frame(width: 55,height: 55).background(Color(self.css.accent)).cornerRadius(100).sheet(isPresented: $eatFlag) {
                                        VStack{
                                            HStack{
                                                Spacer()
                                                
                                                Button("Close"){
                                                    self.eatFlag = false
                                                }
                                                
                                            }.padding(30)
                                            EatsSheet().scrollContentBackground(.hidden)
                                                .presentationDetents([.height(350)])
                                            Spacer()
                                        }
                                    }
                                    
                                    
                                    
                                    Spacer()
                                    Button(action: {
                                        print(self.char.loadChar().health)
                                        if (self.char.loadChar().health > 4){
                                            self.disDrFlag = true
                                            print("taa")
                                        }
                                        self.drFlag = true
                                    }, label: {
                                        Image(systemName: "stethoscope").font(.title).foregroundColor(Color(self.css.text))
                                    }).frame(width: 55,height: 55).background(Color(self.css.accent)).cornerRadius(100).alert(isPresented: $drFlag) {
                                        if(self.disDrFlag == true){
                                            return Alert(title: Text("私は医者です！"),message: Text("健康です。"),dismissButton: .default(Text("OK"),action: {
                                                self.disDrFlag = false
                                            }))
                                        }else{
                                            return Alert(title: Text("私は医者です！"),message: Text("お薬を与えますか？"),primaryButton: .cancel(Text("No")), secondaryButton: .default(Text("Yes"),action: {
                                                print("yes")
                                                self.char.upHealth()
                                            }))
                                        }
                                    }
                                    
                                    
                                    
                                    Spacer()
                                }
                                .frame(width: xposi, height: 70).background(Color(self.css.base)).cornerRadius(100)
                                .animation(.linear, value: xposi)
                                Spacer()
                            }
                        }
                        .frame(width: geoVal.size.width - 10, height: 70)
                        HStack {
                            Button {
                                if(btnFlag){
                                    self.xposi = 0
                                    btnFlag = false
                                }else{
                                    self.xposi = geoVal.size.width - 20
                                    btnFlag = true
                                }
                            } label: {
                                HStack{
                                    Image(systemName: "text.justify").font(.title).foregroundColor(Color(self.css.text))
                                }.frame(width: 70)
                            }.frame(width: 70, height: 70).background(Color(self.css.accent)).cornerRadius(100)
                            Spacer()
                        }.frame(width: geoVal.size.width - 10)
                    }
                }.padding(10)
        }.frame(height: 80).onAppear(){
            self.css.regist(i: cflag)
        }.onChange(of: cflag) { newValue in
            self.css.regist(i: cflag)
        }
        }
    }


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().environmentObject(FireAuthModel()).environmentObject(HealthSleep()).environmentObject(TabModel()).environmentObject(ColorThema())
    }
}
