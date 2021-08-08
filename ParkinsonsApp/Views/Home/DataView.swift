//
//  DataView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI
import CreateML
import TabularData
import CoreML


struct DataView: View {
    @Binding var userData: [UserData]
    @Binding var dataTypes: [String]
    @Binding var habitUserData: UserData
    @State var balance = ChartData(values: [("", 0.0)])
    @State var meds = ChartData(values: [("", 0.0)])
    @State var aysm = ChartData(values: [("", 0.0)])
    @State var length = ChartData(values: [("", 0.0)])
    @State var tremor = ChartData(values: [("", 0.0)])
    @State var score = ChartData(values: [("", 0.0)])
    @State var scorePredicted = ChartData(values: [("", 0.0)])
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
    
    @State var habitName = ""
    @State var habitTitles = [String]()
    //@Binding var experiment: Experiment
    
    @State var average = 0.0
    var body: some View {
        ZStack {
            Color.clear
                .onAppear() {
//                    trainOnDevice(userData: userData, target: .Score) { (score) in
//                        print(score)
//                    }
//                    loadData  { (score) in
//
//
//                    }
                    let habits = userData.filter { data in
                        return data.type == .Habit
                    }
                    habitTitles = habits.map{$0.title}.removeDuplicates()
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
                                HStack {
                                    Text("Average: " + String(average))
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.leading)
                                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                                DatePicker("", selection: $date, displayedComponents: .date)
                                    .datePickerStyle(CompactDatePickerStyle())
                                    .padding()
                                    .onAppear() {
                                        loadData  { (score) in
                                            average = average(numbers: userData.filter { data in
                                                return data.type == .Score && data.data != 21
                                            }.map{$0.data})
                                            
                                        }
                                        let maximum =  ChartData(values: [("", 0.0)])
                                        let filtered2 = score.points.filter { word in
                                            return word.0 != "NA"
                                        }
                                       
                                        let average2 = average(numbers: filtered2.map {$0.1})
                                        let minScore = filtered2.map {$0.1}.max()
                                        let filtered = filtered2.filter { word in
                                            return word.1 == minScore
                                        }
                                        
                                        if average2.isNormal {
                                            maximum.points.append((String("Average"), average2))
                                            maximum.points.append((String(filtered.last?.0 ?? "") , filtered.last?.1 ?? 0.0))
                                            max = maximum
                                            maxText = "At \(max.points.last?.0 ?? "") your score was higher than any other hour today."
                                            
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            withAnimation(.easeInOut) {
                                                refresh = false
                                            }
                                            
                                        }
                                    }
                                
                                }
                                    //.opacity(isTutorial ? (tutorialNum == 1 ? 1.0 : 0.1) : 1.0)
                                    .onChange(of: date, perform: { value in
                                        
                                        refresh = true
                                        loadData  { (score) in
                                            let numbers = userData.filter { data in
                                                return data.type == .Score && data.data != 21
                                            }.map{$0.data}
                                            print(numbers)
                                            average = average(numbers: numbers)
                                            
                                        }
                                        let maximum =  ChartData(values: [("", 0.0)])
                                       
                                        let filtered2 = score.points.filter { word in
                                            return word.0 != "NA"
                                        }
                                       
                                        let average2 = average(numbers: filtered2.map {$0.1})
                                        let minScore = filtered2.map {$0.1}.max()
                                        let filtered = filtered2.filter { word in
                                            return word.1 == minScore
                                        }
                                        
                                        if average2.isNormal {
                                            maximum.points.append((String("Average"), average2))
                                            maximum.points.append((String(filtered.last?.0 ?? "") , filtered.last?.1 ?? 0.0))
                                            max = maximum
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
                                    
                                DayChartView(title: "Score", chartData: $score, refresh: $refresh, dataTypes: $dataTypes, userData: $userData)
                                Text("1 indicates poorer health while a 0 indicates a healthier condition")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.leading)
                                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                                    //.opacity(isTutorial ? (tutorialNum == 2 ? 1.0 : 0.1) : 1.0)
                                
                                if max.points.last?.1 != max.points.first?.1 {
                                    DayChartView(title: "Score", chartData: $max, refresh: $refresh, dataTypes: $dataTypes, userData: $userData)
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
                                        let maximum =  ChartData(values: [("", 0.0)])
                                       
                                        let filtered2 = length.points.filter { word in
                                            return word.0 != "NA"
                                        }
                                       
                                        let average2 = average(numbers: filtered2.map {$0.1})
                                        let minScore = filtered2.map {$0.1}.max()
                                        let filtered = filtered2.filter { word in
                                            return word.1 == minScore
                                        }
                                        
                                        
                                        maximum.points.append((String("Average"), average2))
                                        maximum.points.append((String(filtered.last?.0 ?? "") , filtered.last?.1 ?? 0.0))
                                        max = maximum
                                        maxText = "At \(max.points.last?.0 ?? "") your score was higher than any other hour today."
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
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
                                    DayChartView(title: "Balance", chartData: $balance, refresh: $refresh, dataTypes: $dataTypes, userData: $userData)
                                Text("A higher balance value indicates poorer health.")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.leading)
                                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                                if max.points.last?.1 != max.points.first?.1 {
                                    DayChartView(title: "Balance", chartData: $max, refresh: $refresh, dataTypes: $dataTypes, userData: $userData)
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
                                        
                                        loadData  { (score) in
                                            
                                            
                                        }
                                        let maximum =  ChartData(values: [("", 0.0)])
                                       
                                        let filtered2 = length.points.filter { word in
                                            return word.0 != "NA"
                                        }
                                       
                                        let average2 = average(numbers: filtered2.map {$0.1})
                                        let minScore = filtered2.map {$0.1}.max()
                                        let filtered = filtered2.filter { word in
                                            return word.1 == minScore
                                        }
                                        
                                        
                                        maximum.points.append((String("Average"), average2))
                                        maximum.points.append((String(filtered.last?.0 ?? "") , filtered.last?.1 ?? 0.0))
                                        max = maximum
                                        maxText = "At \(max.points.last?.0 ?? "") your step length was higher than any other hour today."
                                        
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
                                    DayChartView(title: "Step Length", chartData: $length, refresh: $refresh, dataTypes: $dataTypes, userData: $userData)
                                Text("A lower step length indicates poorer health.")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.leading)
                                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                                if max.points.last?.1 != max.points.first?.1 {
                                    DayChartView(title: "Step Length", chartData: $max, refresh: $refresh, dataTypes: $dataTypes, userData: $userData)
                                    Text(maxText)
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                                }
                                }
                            } .padding()
                            .transition(.opacity)
                            
                        case "Speed":
                            DayChartView(title: "Walking Speed", chartData: $score, refresh: $refresh, dataTypes: $dataTypes, userData: $userData)
                        case "Steps":
                            DayChartView(title: "Steps", chartData: $score, refresh: $refresh, dataTypes: $dataTypes, userData: $userData)
                            
                        case "Habits":
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
                                        
                                        loadData  { (score) in
                                            
                                            
                                        }
                                        
//                                        trainHabitCompareOnDevice(userData: userData, target: .Score, target2: habitName) { (score) in
//                                            for i in score.predicted.indices {
//                                                self.score.points = [((String(i), score.actual[i]))]
//
//                                                self.scorePredicted.points = [((String(i), score.predicted[i]))]
//
//                                        }
//                                        }
                                        let maximum =  ChartData(values: [("", 0.0)])
                                        let filtered2 = length.points.filter { word in
                                            return word.0 != "NA"
                                        }
                                       
                                        let average2 = average(numbers: filtered2.map {$0.1})
                                        let minScore = filtered2.map {$0.1}.max()
                                        let filtered = filtered2.filter { word in
                                            return word.1 == minScore
                                        }
                                        
                                        
                                        maximum.points.append((String("Average"), average2))
                                        maximum.points.append((String(filtered.last?.0 ?? "") , filtered.last?.1 ?? 0.0))
                                        max = maximum
                                        
                                        maxText = "At \(max.points.last?.0 ?? "") your score was higher than any other hour today."
                                        
                                       
                                    })
                                
                                HStack {
                                    Text("Score and Habits")
                                        .font(.custom("Poppins-Bold", size: 24, relativeTo: .headline))
                                    Spacer()
                                    ForEach(habitTitles, id: \.self) { title in
                                       
                                        Button(action: {
                                            habitName = title
                                        }) {
                                            Text(title)
                                        }
                                    }
                                }
                                
                                DayChartView(title: "Habit", chartData: $habits, refresh: $refresh, dataTypes: $dataTypes, userData: $userData)
//                                DayChartView(title: "Score", chartData: $score, refresh: $refresh)
//
//
//                                DayChartView(title: "Habits", chartData: $habits, refresh: $refresh)
                                
                                
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
                                        balance.points.removeAll()
                                        aysm.points.removeAll()
                                        length.points.removeAll()
                                        score.points.removeAll()
                                        loadData  { (score) in
                                            
                                            
                                        }
//                                        trainCompareOnDevice(userData: userData, target: .Score, target2: .Meds) { (score) in
//                                            for i in score.predicted.indices {
//                                                self.score.points = [((String(i), score.actual[i]))]
//                                            
//                                                self.scorePredicted.points = [((String(i), score.predicted[i]))]
//                                        }
//                                        }
                                        max.points.removeAll()
                                        let filtered2 = meds.points.filter { word in
                                            return word.0 != "NA"
                                        }
                                       
                                        let average2 = average(numbers: filtered2.map {$0.1})
                                        let minScore = filtered2.map {$0.1}.max()
                                        let filtered = filtered2.filter { word in
                                            return word.1 == minScore
                                        }
                                        
                                        let maximum =  ChartData(values: [("", 0.0)])
                                        maximum.points.append((String("Average"), average2))
                                        maximum.points.append((String(filtered.last?.0 ?? "") , filtered.last?.1 ?? 0.0))
                                        max = maximum
                                        
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
                                
                                DayChartView(title: "Score", chartData: $score, refresh: $refresh, dataTypes: $dataTypes, userData: $userData)
                                
                               // DayChartView(title: "Meds", chartData: $meds, refresh: $refresh)
                                
                                
                            } .padding()
                            .transition(.opacity)
                        default:
                            DayChartView(title: "Score", chartData: $score, refresh: $refresh, dataTypes: $dataTypes, userData: $userData)
                        }
                    }
               
            }
        }
    }
    func loadData( completionHandler: @escaping (String) -> Void) {
       
        score = ChartData(values: [("", 0.0)])
        length = ChartData(values: [("", 0.0)])
        balance = ChartData(values: [("", 0.0)])
        habits = ChartData(values: [("", 0.0)])
        
        let filtered = userData.filter { data in
            return data.date.get(.weekOfYear) == date.get(.weekOfYear) && date.get(.weekday) == data.date.get(.weekday) && date.get(.year) == data.date.get(.year)
        }
        let balancePoints = ChartData(values: [("", 0.0)])
        let scorePoints = ChartData(values: [("", 0.0)])
        let lengthPoints = ChartData(values: [("", 0.0)])
        let asymPoints = ChartData(values: [("", 0.0)])
        let habitPoints = ChartData(values: [("", 0.0)])
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
            let speed = filteredHour.filter { data in
                return  data.type == .WalkingSpeed
            }
            let habits = filteredHour.filter { data in
                return  data.title == habitName
            }
            

            var scores = [Double]()
            for i in double.indices {
                if double.indices.contains(i) && speed.indices.contains(i) && stepLength.indices.contains(i) {
                getLocalScore(double: double[i].data, speed: speed[i].data, length: stepLength[i].data) { (score) in
                    scores.append(score.prediction)
                    
                }
                }
            }
            let averageScore = average(numbers: scores)
        
            scorePoints.points.append((String(hour), averageScore))
            
            
            balancePoints.points.append((String(hour), average(numbers: double.map{$0.data})))
            asymPoints.points.append((String(hour), average(numbers: asymmetry.map{$0.data})))
            lengthPoints.points.append((String(hour), average(numbers: stepLength.map{$0.data})))
            habitPoints.points.append((String(hour), average(numbers: habits.map{$0.data})))
           
 
        score = scorePoints
        length = lengthPoints
        balance = balancePoints
            self.habits = habitPoints
        
        }
    }
//    func trainHabitCompareOnDevice(userData: [UserData], target: DataType, target2: String, completionHandler: @escaping (ModelResponse) -> Void) {
//        var trainingData = DataFrame()
//        let filteredToRemoveNan = userData.filter { data in
//            return data.data.isNormal && !data.data.isNaN
//        }
//        let filteredToTarget = filteredToRemoveNan.filter { data in
//            return data.type == target
//        }
//        
//        let filteredToTarget2 = filteredToRemoveNan.filter { data in
//            return data.type == .Habit
//        }
//        var filteredToHabitTitle = filteredToRemoveNan.filter { data in
//            return data.title == target2
//        }
//           
//           
//            
//          
//            if !filteredToHabitTitle.isEmpty {
//              
//                if filteredToHabitTitle.count > filteredToTarget.count {
//                    for _ in 0...filteredToTarget2.count - filteredToTarget.count {
//                        filteredToHabitTitle.removeFirst()
//                    }
//                    
//                } else if filteredToTarget.count < filteredToHabitTitle.count {
//                    let average =   average(numbers: filteredToHabitTitle.map{$0.data})
//                    for _ in 0...filteredToTarget.count - filteredToTarget2.count {
//                        filteredToHabitTitle.append(UserData(id: UUID().uuidString, type: .Habit, title: "", text: "", date: Date(), data: average))
//                         
//                      
//                }
//                } else {
//                }
//                
//                
//               // print(trainingData.summary())
//                let dataArray = filteredToTarget.map{Double($0.data)}
//                let dataArray2 = filteredToTarget2.map{Double($0.data)}
//                print(average(numbers: dataArray))
//                trainingData.append(column: Column(name: target.rawValue, contents: dataArray))
//               
//                trainingData.append(column: Column(name: target2, contents: dataArray2))
//                    
//                                }
//        
////        var dataArray = [Double]()
////
////
////        trainingData.append(column: Column(name: DataType.Score.rawValue, contents: dataArray))
//
//        let randomSplit = trainingData.randomSplit(by: 0.5)
//        print(randomSplit)
//        let testingData = DataFrame(randomSplit.0)
//        trainingData = DataFrame(randomSplit.1)
//        do {
//            let model = try MLRandomForestRegressor(trainingData: trainingData, targetColumn:  target.rawValue)
//           
//           // try model.write(to: getDocumentsDirectory().appendingPathComponent(DataType.HappinessScore.rawValue + ".mlmodel"))
//            print(model.trainingMetrics)
//            print(model.validationMetrics)
//            let predictions = try model.predictions(from: testingData)
//            print(average(numbers: predictions.map{($0.unsafelyUnwrapped) as! Double}))
//            completionHandler(ModelResponse(type: target.rawValue, predicted: predictions.map{($0.unsafelyUnwrapped) as! Double}, actual: filteredToTarget.map{Double($0.data)}, accuracy: model.trainingMetrics.rootMeanSquaredError))
//        } catch {
//            print(error)
//
//        }
//
//    }
//    func trainCompareOnDevice(userData: [UserData], target: DataType, target2: DataType, completionHandler: @escaping (ModelResponse) -> Void) {
//        var trainingData = DataFrame()
//        let filteredToRemoveNan = userData.filter { data in
//            return data.data.isNormal && !data.data.isNaN
//        }
//        let filteredToTarget = filteredToRemoveNan.filter { data in
//            return data.type == target
//        }
//        
//        var filteredToTarget2 = filteredToRemoveNan.filter { data in
//            return data.type == target2
//        }
//      
//           
//           
//            
//          
//            if !filteredToTarget2.isEmpty {
//              
//                if filteredToTarget2.count > filteredToTarget.count {
//                    for _ in 0...filteredToTarget2.count - filteredToTarget.count {
//                        filteredToTarget2.removeFirst()
//                    }
//                    
//                } else if filteredToTarget.count < filteredToTarget2.count {
//                    let average =   average(numbers: filteredToTarget2.map{$0.data})
//                    for _ in 0...filteredToTarget.count - filteredToTarget2.count {
//                        filteredToTarget2.append(UserData(id: UUID().uuidString, type: target2, title: "", text: "", date: Date(), data: average))
//                         
//                      
//                }
//                } else {
//                }
//                
//                
//               // print(trainingData.summary())
//                let dataArray = filteredToTarget.map{Double($0.data)}
//                let dataArray2 = filteredToTarget2.map{Double($0.data)}
//                print(average(numbers: dataArray))
//                trainingData.append(column: Column(name: target.rawValue, contents: dataArray))
//               
//                trainingData.append(column: Column(name: target2.rawValue, contents: dataArray2))
//                    
//                                }
//        
//        let dataArray = [Double]()
//        
//       
//        trainingData.append(column: Column(name: DataType.Score.rawValue, contents: dataArray))
//
//        let randomSplit = trainingData.randomSplit(by: 0.5)
//        print(randomSplit)
//        let testingData = DataFrame(randomSplit.0)
//        trainingData = DataFrame(randomSplit.1)
//        do {
//            let model = try MLRandomForestRegressor(trainingData: trainingData, targetColumn:  target.rawValue)
//           
//           // try model.write(to: getDocumentsDirectory().appendingPathComponent(DataType.HappinessScore.rawValue + ".mlmodel"))
//            print(model.trainingMetrics)
//            print(model.validationMetrics)
//            let predictions = try model.predictions(from: testingData)
//        
//            completionHandler(ModelResponse(type: target.rawValue, predicted: predictions.map{($0.unsafelyUnwrapped) as! Double}, actual: filteredToTarget.map{Double($0.data)}, accuracy: model.trainingMetrics.rootMeanSquaredError))
//        } catch {
//            print(error)
//
//        }
//
//    }
//    func trainOnDevice(userData: [UserData], target: DataType, completionHandler: @escaping (PredictedScore) -> Void) {
//        do {
//            let csvFile = Bundle.main.url(forResource: "BaseData", withExtension: "csv")!
//            let baseData = try DataFrame(contentsOfCSVFile: csvFile)
//        var trainingData = DataFrame()
//        let filteredToRemoveNan = userData.filter { data in
//            return data.data.isNormal && !data.data.isNaN
//        }
//        var filteredToBalance = filteredToRemoveNan.filter { data in
//            return data.type == .Balance
//        }
//        
//        for type in DataType.allCases {
//            print(type)
//           
//            var filteredToType = filteredToRemoveNan.filter { data in
//                return data.type == type && data.type != .Score
//            }
//            
//          
//            if !filteredToType.isEmpty {
//              
//                
//                if filteredToType.count > 2000 {
//                    for _ in 0...filteredToType.count - 2000 {
//                    filteredToType.removeFirst()
//                    }
//                    filteredToBalance = filteredToType
//                } else if 2000 < filteredToType.count {
//                    let average =   average(numbers: filteredToType.map{$0.data})
//                    for _ in 0...2000 - filteredToType.count {
//                        filteredToType.append(UserData(id: UUID().uuidString, type: type, title: "", text: "", date: Date(), data: average))
//                         
//                        filteredToBalance = filteredToType
//                }
//                } else {
//                }
//                
//                
//               // print(trainingData.summary())
//                let dataArray = filteredToType.map{Double($0.data)}
//                print(average(numbers: dataArray))
//            trainingData.append(column: Column(name: type.rawValue, contents: dataArray))
//                
//                print(filteredToType.count)
//                                }
//        }
//        var dataArray = [Double]()
//        
//        print(trainingData.rows.count )
//            for _ in 0...filteredToBalance.count - 1 {
//            dataArray.append(Double(0))
//        }
//        trainingData.append(column: Column(name: DataType.Score.rawValue, contents: dataArray))
//           
//        let randomSplit = trainingData.randomSplit(by: 0.5)
//        print(randomSplit)
//        let testingData = DataFrame(randomSplit.0)
//        trainingData = DataFrame(randomSplit.1)
//            trainingData.append(baseData)
//        do {
//            let model = try MLRandomForestRegressor(trainingData: trainingData, targetColumn:  target.rawValue)
//           
//           // try model.write(to: getDocumentsDirectory().appendingPathComponent(DataType.HappinessScore.rawValue + ".mlmodel"))
//            print(model.trainingMetrics)
//            print(model.validationMetrics)
//            let predictions = try model.predictions(from: testingData)
//            print(average(numbers: predictions.map{($0.unsafelyUnwrapped) as! Double}))
//        } catch {
//            print(error)
//
//        }
//
//        } catch {
//            
//        }
//        }

    func getLocalScore(double: Double, speed: Double, length: Double, completionHandler: @escaping (PredictedScore) -> Void) {
        do {
            let model = try reg_model(configuration: MLModelConfiguration())
            let prediction =  try model.prediction(double_: double, speed: speed, length: length)
            completionHandler(PredictedScore(prediction: prediction.sourceName, predicted_parkinsons: prediction.sourceName > 0.5 ? 1 : 0, date: Date()))
        } catch {
            
        }
    }
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    func average(numbers: [Double]) -> Double {
        // print(numbers)
        return Double(numbers.reduce(0,+))/Double(numbers.count)
    }
}

