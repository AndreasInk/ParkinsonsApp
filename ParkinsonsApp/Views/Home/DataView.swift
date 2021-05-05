//
//  DataView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI

struct DataView: View {
    @Binding var days: [Day]
    @State var balance = ChartData(values: [("", 0.0)])
    @State var aysm = ChartData(values: [("", 0.0)])
    @State var length = ChartData(values: [("", 0.0)])
    @State var tremor = ChartData(values: [("", 0.0)])
    @State var score = ChartData(values: [("", 0.0)])
    @State var gridButton: GridButton
    @State private var date = Date()
    @State var ready = false
    @State var maxText = ""
    let model = reg_model()
    @State var refresh = false
  @State var min =  ChartData(values: [("", 0.0)])
    @State var max =  ChartData(values: [("", 0.0)])
    var body: some View {
        ZStack {
            Color.clear
                .onAppear() {
                    loadData  { (score) in
                    
                      
                    }
                   
                    let filtered2 = score.points.filter { word in
                        return word.0 != "NA"
                    }
                    print(filtered2)
                    let average = average(numbers: filtered2.map {$0.1})
                   let minScore = filtered2.map {$0.1}.max()
                    let filtered = filtered2.filter { word in
                        return word.1 == minScore
                    }
                    
                   
                    max.points.append((String("Average"), average))
                    max.points.append((String(filtered.last?.0 ?? "") , filtered.last?.1 ?? 0.0))
                    maxText = "At \(max.points.last?.0 ?? "") your score was higher than any other hour today."
                }
            VStack {
                ScrollView {
                
            if !refresh {
        switch gridButton.title {
        case "Score":
            VStack {
                DatePicker("", selection: $date, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                    .padding()
                    .onChange(of: date, perform: { value in
                        // ready = false
                        refresh = true
                        loadData  { (score) in
                            
                            
                        }
                        max.points.removeAll()
                        let filtered2 = score.points.filter { word in
                            return word.0 != "NA"
                        }
                        print(filtered2)
                        let average = average(numbers: filtered2.map {$0.1})
                       let minScore = filtered2.map {$0.1}.max()
                        let filtered = filtered2.filter { word in
                            return word.1 == minScore
                        }
                        
                        if average.isNormal {
                        max.points.append((String("Average"), average))
                        max.points.append((String(filtered.last?.0 ?? "") , filtered.last?.1 ?? 0.0))
                        
                        maxText = "At \(max.points.last?.0 ?? "") your score was higher than any other hour today."
                        print(days)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.easeInOut) {
                        refresh = false
                            }
                        
                        }
                    })
                HStack {
                Text("Total Score")
                    .font(.custom("Poppins-Bold", size: 24, relativeTo: .headline))
                    Spacer()
                }
                DayChartView(title: "Score", chartData: $score, refresh: $refresh)
            Text("Overtime your score may change depending on how you are feeling, use your score with your doctor to determine what habits are working best to improve your health, generally a higher score indicates poorer health.")
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                if max.points.last?.1 != max.points.first?.1 {
                    DayChartView(title: "Score", chartData: $max, refresh: $refresh)
                Text(maxText)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                }
            } .padding()
            .transition(.opacity)
            
        case "Balance":
            VStack {
                DatePicker("", selection: $date, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                    .padding()
                    .onChange(of: date, perform: { value in
                        // ready = false
                        refresh = true
                        loadData  { (score) in
                            
                            
                        }
                        max.points.removeAll()
                        let filtered2 = balance.points.filter { word in
                            return word.0 != "NA"
                        }
                        print(filtered2)
                        let average = average(numbers: filtered2.map {$0.1})
                       let minScore = filtered2.map {$0.1}.max()
                        let filtered = filtered2.filter { word in
                            return word.1 == minScore
                        }
                        
                       
                        max.points.append((String("Average"), average))
                        max.points.append((String(filtered.last?.0 ?? "") , filtered.last?.1 ?? 0.0))
                        
                        maxText = "At \(max.points.last?.0 ?? "") your score was higher than any other hour today."
                        print(days)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.easeInOut) {
                        refresh = false
                            }
                        }
                    })
                HStack {
                Text("Balance")
                    .font(.custom("Poppins-Bold", size: 24, relativeTo: .headline))
                    Spacer()
                }
                DayChartView(title: "Balance", chartData: $balance, refresh: $refresh)
            Text("Overtime your balance may change depending on how you are feeling, use your score with your doctor to determine what habits are working best to improve your health, generally a higher balance value indicates poorer health.")
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                if max.points.last?.1 != max.points.first?.1 {
                    DayChartView(title: "Balance", chartData: $max, refresh: $refresh)
                Text(maxText)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                }
            } .padding()
            .transition(.opacity)
            
        case "Stride":
            VStack {
                DatePicker("", selection: $date, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                    .padding()
                    .onChange(of: date, perform: { value in
                        // ready = false
                        refresh = true
                        loadData  { (score) in
                            
                            
                        }
                        max.points.removeAll()
                        let filtered2 = length.points.filter { word in
                            return word.0 != "NA"
                        }
                        print(filtered2)
                        let average = average(numbers: filtered2.map {$0.1})
                       let minScore = filtered2.map {$0.1}.max()
                        let filtered = filtered2.filter { word in
                            return word.1 == minScore
                        }
                        
                       
                        max.points.append((String("Average"), average))
                        max.points.append((String(filtered.last?.0 ?? "") , filtered.last?.1 ?? 0.0))
                        
                        maxText = "At \(max.points.last?.0 ?? "") your score was higher than any other hour today."
                        print(days)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.easeInOut) {
                        refresh = false
                            }
                        }
                    })
                HStack {
                Text("Step Length")
                    .font(.custom("Poppins-Bold", size: 24, relativeTo: .headline))
                    Spacer()
                }
                DayChartView(title: "Step Length", chartData: $length, refresh: $refresh)
            Text("Overtime your balance may change depending on how you are feeling, use your score with your doctor to determine what habits are working best to improve your health, generally a higher balance value indicates poorer health.")
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                if max.points.last?.1 != max.points.first?.1 {
                    DayChartView(title: "Step Length", chartData: $max, refresh: $refresh)
                Text(maxText)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                }
            } .padding()
            .transition(.opacity)
            
        case "Speed":
            DayChartView(title: "Walking Speed", chartData: $score, refresh: $refresh)
        case "Steps":
            DayChartView(title: "Steps", chartData: $score, refresh: $refresh)
        default:
            DayChartView(title: "Score", chartData: $score, refresh: $refresh)
        }
            }
        }
            }
        }
    }
    func loadData( completionHandler: @escaping (String) -> Void) {
        balance.points.removeAll()
        aysm.points.removeAll()
        length.points.removeAll()
        tremor.points.removeAll()
        score.points.removeAll()
        print("DATE")
        print(date.get(.day))
        let filtered = days.filter { b in
            print("bsnjhdjhduhsduhsduhd")
            print( b.balance.last?.date.get(.day))
                   print(date.get(.day))
            return b.walkingSpeed.last?.date.get(.day) ?? 0 == date.get(.day)
        }
        print(filtered)
        let day = filtered.last ?? Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0)
            print(1)
            let components = date.get(.day, .month, .year, .hour)
            let components2 = day.walkingSpeed.last?.date.get(.day, .month, .year, .hour)
        if let today = components2?.day, let month = components2?.month, let year = components2?.year, let hour = components2?.hour {
            if let today2 = components.day, let month2 = components.month, let year2 = components.year {
                print("day: \(day), month: \(month), year: \(year)")
            
            if "\(today)" + "\(month)" + "\(year)" == "\(today2)" + "\(month2)" +  "\(year2)" {
                
                
                var dates = day.balance.map { $0.date }.sorted()
                var previousHour = -1
                for i in 0...23 {
                   
                   
                   // if !balance.points.isEmpty {
                        let filtered = day.balance.filter { b in
                            return b.date.get(.hour) == i
                        }
                       // print(filtered)
                        let hours = balance.points.map {$0.0}.sorted()
                        let nums = filtered.map {$0.value}
                        let value = average(numbers: nums)
                           // print(value)
                        if  !average(numbers: filtered.map {$0.value}).isNaN {
                            balance.points.append((String(filtered.last!.date.get(.hour) ), average(numbers: filtered.map {$0.value})))
                            print("HERE")
                            print(balance.points)
                        }
                       
                        previousHour = hour
                    
                }
              
                
               
                var dates2 = day.aysm.map { $0.date }
                var previousHour2 = -1
                for i in 0...23 {
                   
                   
                   // if !balance.points.isEmpty {
                        let filtered = day.aysm.filter { b in
                            return b.date.get(.hour) == i
                        }
                       // print(filtered)
                        let hours = aysm.points.map {$0.0}.sorted()
                        let nums = filtered.map {$0.asym}
                        let value = average(numbers: nums)
                           // print(value)
                        if  !average(numbers: filtered.map {$0.asym}).isNaN {
                            aysm.points.append((String(filtered.last!.date.get(.hour) ), average(numbers: filtered.map {$0.asym})))
                        }
                       
                        previousHour = hour
                    
                }
                var dates3 = day.strideLength.map { $0.date }
                var previousHour3 = -1
                for i in 0...23 {
                   
                   
                   // if !balance.points.isEmpty {
                        let filtered = day.strideLength.filter { b in
                            return b.date.get(.hour) == i
                        }
                       // print(filtered)
                        let hours = length.points.map {$0.0}.sorted()
                        let nums = filtered.map {$0.length}
                        let value = average(numbers: nums)
                           // print(value)
                        if  !average(numbers: filtered.map {$0.length}).isNaN {
                            length.points.append((String(filtered.last!.date.get(.hour) ), average(numbers: filtered.map {$0.length})))
                        }
                       
                        previousHour = hour
                    
                }
//                var dates4 = day.score.map { $0.date }
//                var previousHour4 = -1
//                for i in 0...23 {
//
//
//                   // if !balance.points.isEmpty {
//                        let filtered = day.score.filter { b in
//                            return b.date.get(.hour) == i
//                        }
//                       // print(filtered)
//                    let hours = score.points.map {$0.0}.sorted()
//                        let nums = filtered.map {$0.score}
//                        let value = average(numbers: nums)
//                           // print(value)
//                        if  !average(numbers: filtered.map {$0.score}).isNaN {
//                            score.points.append((String(filtered.last!.date.get(.hour) ), average(numbers: filtered.map {$0.score})))
//                        }
//
//                        previousHour = hour
//
//                }
               
     }

            }
            for i in 0...23 {
                
                let filtered = day.balance.filter { b in
                    print(b.date)
                    return b.date.get(.hour) == i
                }
                
                let filtered2 = day.strideLength.filter { b in
                    return b.date.get(.hour) == i
                }
                
                let filtered3 = day.walkingSpeed.filter { b in
                    return b.date.get(.hour) == i
                }
                if filtered.count > 0 {
                getLocalScore(double: average(numbers: filtered.map {$0.value}), speed: average(numbers: filtered3.map {$0.speed}), length:  average(numbers: filtered2.map {$0.length})) { (score) in
                    self.score.points.append((String(i), score.prediction))
                }
                } else {
                    getLocalScore(double: average(numbers: filtered.map {$0.value}), speed: average(numbers: filtered3.map {$0.speed}), length:  average(numbers: filtered2.map {$0.length})) { (score) in
                        self.score.points.append((String("NA"), 0.0))
                }
            }
                
            }
        }
        ready = true
    
    }
    func getLocalScore(double: Double, speed: Double, length: Double, completionHandler: @escaping (PredictedScore) -> Void) {
        do {
            let prediction =  try self.model.prediction(double_: double, speed: speed, length: length)
            completionHandler(PredictedScore(prediction: prediction.sourceName, predicted_parkinsons: prediction.sourceName > 0.5 ? 1 : 0))
        } catch {

        }
    }
    func average(numbers: [Double]) -> Double {
       // print(numbers)
        return Double(numbers.reduce(0,+))/Double(numbers.count)
    }
}

