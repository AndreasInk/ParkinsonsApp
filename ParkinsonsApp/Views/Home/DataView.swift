//
//  DataView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI
import CoreML

struct DataView: View {
    @Binding var days: [Day]
    @State var balance = ChartData(values: [("", 0.0)])
    @State var meds = ChartData(values: [("", 0.0)])
    @State var aysm = ChartData(values: [("", 0.0)])
    @State var length = ChartData(values: [("", 0.0)])
    @State var tremor = ChartData(values: [("", 0.0)])
    @State var score = ChartData(values: [("", 0.0)])
    @State var habits = ChartData(values: [("", 0.0)])
    @State var gridButton: GridButton
    @State private var date = Date()
    @State var ready = false
    @State var maxText = ""
    @State var refresh = false
    @State var min =  ChartData(values: [("", 0.0)])
    @State var max =  ChartData(values: [("", 0.0)])
    
    @Binding var tutorialNum: Int
    @Binding var isTutorial: Bool
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Color.clear
                .onAppear() {
                    loadData  { (score) in
                        
                        
                    }
                    
                    let filtered2 = score.points.filter { word in
                        return word.0 != "NA"
                    }
                   
                    let average2 = average(numbers: filtered2.map {$0.1})
                    let minScore = filtered2.map {$0.1}.max()
                    let filtered = filtered2.filter { word in
                        return word.1 == minScore
                    }
                    
                    
                    max.points.append((String("Average"), average2))
                    max.points.append((String(filtered.last?.0 ?? "") , filtered.last?.1 ?? 0.0))
                    maxText = "At \(max.points.last?.0 ?? "") your score was higher than any other hour today."
                }
            VStack {
                if isTutorial {
                    VStack {
                       
                        Text( tutorialNum == 1 ? "Tap and hold to slide through your data or select a date in the top right to change the date" : tutorialNum == 2 ? "Tap and hold to slide through your data or select a date in the top right to change the date" : tutorialNum == 3 ? "Tap and hold to slide through your data or select a date in the top right to change the date" : "")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                            .padding()
                        
                        Button(action: {
                        
                        presentationMode.wrappedValue.dismiss()
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .foregroundColor(Color(.lightGray))
                                    .frame(height: 75)
                                    .padding()
                                Text("Next")
                                    .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                                    .foregroundColor(.white)
                            }
                        } .buttonStyle(CTAButtonStyle())
                }
                }
                if !isTutorial {
               DismissSheetBtn()
                }
                ScrollView {
                    
                    
                        switch gridButton.title {
                        case "Score":
                            ZStack {
                            VStack {
                                
                                DatePicker("", selection: $date, displayedComponents: .date)
                                    .datePickerStyle(CompactDatePickerStyle())
                                    .padding()
                                    //.opacity(isTutorial ? (tutorialNum == 1 ? 1.0 : 0.1) : 1.0)
                                    .onChange(of: date, perform: { value in
                                        // ready = false
                                        
                                        refresh = true
                                        loadData  { (score) in
                                            
                                            
                                        }
                                        max.points.removeAll()
                                        let filtered2 = score.points.filter { word in
                                            return word.0 != "NA"
                                        }
                                       
                                        let average2 = average(numbers: filtered2.map {$0.1})
                                        let minScore = filtered2.map {$0.1}.max()
                                        let filtered = filtered2.filter { word in
                                            return word.1 == minScore
                                        }
                                        
                                        if average2.isNormal {
                                            max.points.append((String("Average"), average2))
                                            max.points.append((String(filtered.last?.0 ?? "") , filtered.last?.1 ?? 0.0))
                                            
                                            maxText = "At \(max.points.last?.0 ?? "") your score was higher than any other hour today."
                                            
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
                                }  //.opacity(isTutorial ? (tutorialNum == 2 ? 1.0 : 0.1) : 1.0)
                                if !refresh {
                                    
                                DayChartView(title: "Score", chartData: $score, refresh: refresh)
                                Text("1 indicates poorer health while a 0 indicates a healthier condition")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.leading)
                                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                                    //.opacity(isTutorial ? (tutorialNum == 2 ? 1.0 : 0.1) : 1.0)
                                
                                if max.points.last?.1 != max.points.first?.1 {
                                    DayChartView(title: "Score", chartData: $max, refresh: refresh)
                                    Text(maxText)
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                                }
                                }
                               
                                
                            } .padding()
                               
                            }
                            .transition(.slide)
                            
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
                                       
                                        let average2 = average(numbers: filtered2.map {$0.1})
                                        let minScore = filtered2.map {$0.1}.max()
                                        let filtered = filtered2.filter { word in
                                            return word.1 == minScore
                                        }
                                        
                                        
                                        max.points.append((String("Average"), average2))
                                        max.points.append((String(filtered.last?.0 ?? "") , filtered.last?.1 ?? 0.0))
                                        
                                        maxText = "At \(max.points.last?.0 ?? "") your score was higher than any other hour today."
                                        
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
                                if !refresh {
                                DayChartView(title: "Balance", chartData: $balance, refresh: refresh)
                                Text("A higher balance value indicates poorer health.")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.leading)
                                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                                if max.points.last?.1 != max.points.first?.1 {
                                    DayChartView(title: "Balance", chartData: $max, refresh: refresh)
                                    Text(maxText)
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                                }
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
                                       
                                        let average2 = average(numbers: filtered2.map {$0.1})
                                        let minScore = filtered2.map {$0.1}.max()
                                        let filtered = filtered2.filter { word in
                                            return word.1 == minScore
                                        }
                                        
                                        
                                        max.points.append((String("Average"), average2))
                                        max.points.append((String(filtered.last?.0 ?? "") , filtered.last?.1 ?? 0.0))
                                        
                                        maxText = "At \(max.points.last?.0 ?? "") your score was higher than any other hour today."
                                        
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
                                if !refresh {
                                DayChartView(title: "Step Length", chartData: $length, refresh: refresh)
                                Text("A higher step length indicates poorer health.")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.leading)
                                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                                if max.points.last?.1 != max.points.first?.1 {
                                    DayChartView(title: "Step Length", chartData: $max, refresh: refresh)
                                    Text(maxText)
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                                }
                                }
                            } .padding()
                            .transition(.opacity)
                            
                        case "Speed":
                            DayChartView(title: "Walking Speed", chartData: $score, refresh: refresh)
                        case "Steps":
                            DayChartView(title: "Steps", chartData: $score, refresh: refresh)
                            
                        case "Score and Habits":
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
                                       
                                        let average2 = average(numbers: filtered2.map {$0.1})
                                        let minScore = filtered2.map {$0.1}.max()
                                        let filtered = filtered2.filter { word in
                                            return word.1 == minScore
                                        }
                                        
                                        
                                        max.points.append((String("Average"), average2))
                                        max.points.append((String(filtered.last?.0 ?? "") , filtered.last?.1 ?? 0.0))
                                        
                                        maxText = "At \(max.points.last?.0 ?? "") your score was higher than any other hour today."
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            withAnimation(.easeInOut) {
                                                refresh = false
                                            }
                                        }
                                    })
                                HStack {
                                    Text("Score and Habits")
                                        .font(.custom("Poppins-Bold", size: 24, relativeTo: .headline))
                                    Spacer()
                                }
                                DayChartView(title: "Score", chartData: $score, refresh: refresh)
                                
                                
                                DayChartView(title: "Habits", chartData: $habits, refresh: refresh)
                                
                                
                            } .padding()
                            .transition(.opacity)
                        case "Score and Meds":
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
                                        let filtered2 = meds.points.filter { word in
                                            return word.0 != "NA"
                                        }
                                       
                                        let average2 = average(numbers: filtered2.map {$0.1})
                                        let minScore = filtered2.map {$0.1}.max()
                                        let filtered = filtered2.filter { word in
                                            return word.1 == minScore
                                        }
                                        
                                        
                                        max.points.append((String("Average"), average2))
                                        max.points.append((String(filtered.last?.0 ?? "") , filtered.last?.1 ?? 0.0))
                                        
                                        maxText = "At \(max.points.last?.0 ?? "") your score was higher than any other hour today."
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            withAnimation(.easeInOut) {
                                                refresh = false
                                            }
                                        }
                                    })
                                HStack {
                                    Text("Score and Meds")
                                        .font(.custom("Poppins-Bold", size: 24, relativeTo: .headline))
                                    Spacer()
                                }
                                DayChartView(title: "Score", chartData: $score, refresh: refresh)
                                
                                
                                DayChartView(title: "Meds", chartData: $meds, refresh: refresh)
                                
                                
                            } .padding()
                            .transition(.opacity)
                        default:
                            DayChartView(title: "Score", chartData: $score, refresh: refresh)
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
        habits.points.removeAll()
        meds.points.removeAll()
       
        let filtered = days.filter { b in
            
            return b.walkingSpeed.last?.date.get(.day) ?? 0 == date.get(.day)
        }
        let filtered2 = days.filter { b in
            
            
            return b.habit.last?.date.get(.day) ?? 0 == date.get(.day)
        }
        
        let day = filtered.last ?? Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]())
        let day2 = filtered2.last ?? Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]())
        let components22 = date.get(.day, .month, .year, .hour)
        let components222 = day2.habit.last?.date.get(.day, .month, .year, .hour)
        if let today = components222?.day, let month = components222?.month, let year = components222?.year{
            if let today2 = components22.day, let month2 = components22.month, let year2 = components22.year {
              
                
                if "\(today)" + "\(month)" + "\(year)" == "\(today2)" + "\(month2)" +  "\(year2)" {
                   
                    for i in 0...23 {
                        
                        
                        // if !balance.points.isEmpty {
                        let filtered = day2.habit.filter { b in
                            return b.date.get(.hour) == i
                        }
                        
                        
                        habits.points.append((String(filtered.last?.date.get(.hour) ?? 0 ), Double(filtered.count)))
                        
                        
                        
                    }
                }
            }
        }
        
        
        let components = date.get(.day, .month, .year, .hour)
        let components2 = day.walkingSpeed.last?.date.get(.day, .month, .year, .hour)
        if let today = components2?.day, let month = components2?.month, let year = components2?.year {
            if let today2 = components.day, let month2 = components.month, let year2 = components.year {
              
                
                if "\(today)" + "\(month)" + "\(year)" == "\(today2)" + "\(month2)" +  "\(year2)" {
                    
                    
                    
                    for i in 0...23 {
                        
                        
                        // if !balance.points.isEmpty {
                        let filtered = day.balance.filter { b in
                            return b.date.get(.hour) == i
                        }
                        
                        if  !average(numbers: filtered.map {$0.value}).isNaN {
                            balance.points.append((String(filtered.last!.date.get(.hour) ), average(numbers: filtered.map {$0.value})))
                          
                           
                        }
                        
                        
                        
                    }
                    
                    
                    
                    
                    for i in 0...23 {
                        
                        
                        // if !balance.points.isEmpty {
                        let filtered = day.aysm.filter { b in
                            return b.date.get(.hour) == i
                        }
                        // print(filtered)
                        
                        
                        
                        // print(value)
                        if  !average(numbers: filtered.map {$0.asym}).isNaN {
                            aysm.points.append((String(filtered.last!.date.get(.hour) ), average(numbers: filtered.map {$0.asym})))
                        }
                        
                        
                        
                    }
                    
                    for i in 0...23 {
                        
                        let filteredM = day.meds.filter { b in
                            return b.date.get(.hour) == i
                        }
                        
                        meds.points.append((String(filteredM.last?.date.get(.hour) ?? 0), average(numbers: filteredM.map {$0.amountTaken})))
                        // if !balance.points.isEmpty {
                        let filtered = day.strideLength.filter { b in
                            return b.date.get(.hour) == i
                        }
                        // print(filtered)
                        
                        
                        
                        // print(value)
                        if  !average(numbers: filtered.map {$0.length}).isNaN {
                            length.points.append((String(filtered.last!.date.get(.hour) ), average(numbers: filtered.map {$0.length})))
                        }
                        
                        // print(filtered)
                        
                        
                        
                        // print(value)
                        
                            
                        
                        
                        
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
        refresh = true
        ready = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            refresh = false
        }
        
    }
    func getLocalScore(double: Double, speed: Double, length: Double, completionHandler: @escaping (PredictedScore) -> Void) {
        do {
            let model = try reg_model(configuration: MLModelConfiguration())
            let prediction =  try model.prediction(double_: double, speed: speed, length: length)
            completionHandler(PredictedScore(prediction: prediction.sourceName, predicted_parkinsons: prediction.sourceName > 0.5 ? 1 : 0, date: Date()))
        } catch {
            
        }
    }
    func average(numbers: [Double]) -> Double {
        // print(numbers)
        return Double(numbers.reduce(0,+))/Double(numbers.count)
    }
}

