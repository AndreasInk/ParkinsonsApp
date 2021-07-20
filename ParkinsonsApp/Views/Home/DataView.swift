//
//  DataView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI
import CoreML

struct DataView: View {
    @Binding var userData: [UserData]
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
    @State var edit = false
    
    @Environment(\.presentationMode) var presentationMode
    
    //@Binding var experiment: Experiment
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
                                Text("A lower step length indicates poorer health.")
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
                                HStack {
                                    
                                    Button(action: {
                                        edit = true
                                    }) {
                                        Text("Edit")
                                            .font(.custom("Poppins-Bold", size: 18, relativeTo: .title))
                                            .multilineTextAlignment(.leading)
                                    }
                                    .sheet(isPresented: $edit, content: {
                                      // EditExperimentView(experiment: $experiment, add: $edit, refresh: $refresh)
                                    })
                                DatePicker("", selection: $date, displayedComponents: .date)
                                    .datePickerStyle(CompactDatePickerStyle())
                                    .padding()
                                    
                                } 
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
       
       
        let filtered = userData.filter { data in
            return data.date.get(.weekOfYear) == Date().get(.weekOfYear) && date.get(.weekday) == data.date.get(.weekday)
        }
        for hour in 0...23 {
            
       
            let filteredHour = filtered.filter { data in
                return data.date.get(.hour) == hour
            }
            let double = filteredHour.filter { data in
                return  data.type == .Balance
            }
        
            let asymmetry = filteredHour.filter { data in
                return  data.type == .Asymmetry
            }
            let stepLength = filteredHour.filter { data in
                return  data.type == .Stride
            }
                balance.points.append((String(hour), average(numbers: double.map{$0.data})))
                aysm.points.append((String(hour), average(numbers: asymmetry.map{$0.data})))
                length.points.append((String(hour), average(numbers: stepLength.map{$0.data})))
            
        
        refresh = true
        ready = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            refresh = false
        
        }
    
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

