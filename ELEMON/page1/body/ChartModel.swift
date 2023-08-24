import SwiftUI
import Charts

struct BodyGrafView: View {
    
    // グラフの色
//    var pointColor: Color
    
    var Cm = ChartModel()
    
    @State var tx:String = ""
    
    //  グラフデータ
    @State var charta = [BodyCharts]()
    
    var body: some View {
        VStack{
            TextField("", text: $tx).textFieldStyle(.roundedBorder)
            Button("on"){
                // キャストしてデータをアペンド
                self.Cm.add(val: Double(tx) ?? 0)
                
                // Stateのデータ更新
                charta = self.Cm.data
            }
            // グラフビュー
            Chart(charta){ point in
                BarMark(
                    x: .value("title", point.title),
                    y: .value("name", point.value)
                ).foregroundStyle(.pink)
            }
        }
    }
}

// charts -> 構造体。雛形
struct BodyCharts: Identifiable {
    var title: String
    var value: Double
    var color: Color = .green
    var id: String {
        return title + String(value)
    }
}

// グラフのモデル
class ChartModel{
    
    var data:[BodyCharts] = []
    var weightGRF:[BodyCharts] = []
    var BMIGRF:[BodyCharts] = []
    var d:Int = 1
    
    func add(val:Double){
        let s:String = "day\(String(d))"
        data.append(BodyCharts(title: s, value: val))
        self.d += 1
        print(data)
    }
    
    func viewWei(){
        weightGRF = []
        let getVal = UserDefaults.standard.array(forKey: "WEI") as! [Double]
        var day = 7
        print(getVal.count)
        for i in 0..<getVal.count{
            weightGRF.append(BodyCharts(title: "day\(String(day))", value: getVal[i]))
            day -= 1
            
        }
        
        print(weightGRF)
    }
    func viewBMI() {
        BMIGRF = []
//        let getVal = UserDefaults.standard.array(forKey: "BMI") as! [Double]
        guard let getVal = UserDefaults.standard.array(forKey: "BMI") as? [Double] else {
            let getVal = [0.0,0.0,0.0,0.0,0.0,0.0,0.0]
            var day = 7
            print(getVal.count)
            for i in 0..<getVal.count{
                BMIGRF.append(BodyCharts(title: "day\(String(day))", value: getVal[i]))
                day -= 1
            }
            return
        }
        var day = 7
        
        let c = 7 - getVal.count
        if(c>0){
            for _ in 0..<c{
                BMIGRF.append(BodyCharts(title: "day\(String(day))", value: 0))
                day -= 1
            }
        }
        print(getVal.count)
        for i in 0..<getVal.count{
            BMIGRF.append(BodyCharts(title: "day\(String(day))", value: getVal[i]))
            day -= 1
            
        }
        
        
//        print(weightGRF)
    }
    
    // 初回起動用
    func initData(){
        let setVal:[Double] = [0.0,0.0,0.0,0.0,0.0,0.0,0.0]
        UserDefaults.standard.set(setVal, forKey: "WEI")
        UserDefaults.standard.set(setVal, forKey: "BMI")
        print(setVal)
    }
    
    // 体重
    func saveWeight(wei:Double){
        print(wei)
        var setVal:[Double] = UserDefaults.standard.array(forKey: "WEI") as? [Double] ?? [Double]()
        setVal.append(wei)
        setVal.remove(at: 0)
        
        print("debug\(UserDefaults.standard.array(forKey: "WEI") as? [Double] ?? [Double]())")
        
        UserDefaults.standard.set(setVal, forKey: "WEI")
    }
    
    // BMI
    func saveBMI(bmi:Double){
        var setVal:[Double] = UserDefaults.standard.array(forKey: "BMI") as? [Double] ?? [Double]()
        setVal.append(bmi)
        setVal.remove(at: 0)
        
        UserDefaults.standard.set(setVal, forKey: "BMI")
    }
}


struct ContentViewx: View {
    var body: some View {
        BodyGrafView()
    }
    
}

struct GrafView_Previewsx: PreviewProvider {
    static var previews: some View {
        ContentViewx()
    }
}
