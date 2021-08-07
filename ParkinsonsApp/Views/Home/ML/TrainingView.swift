//
//  MachineLearningView.swift
//  MachineLearningView
//
//  Created by Andreas on 8/3/21.
//

import SwiftUI
import CoreML
import CreateML
import TabularData
import HealthKit
import SFSafeSymbols
struct TrainingView: View {
    @Binding var userData: [UserData]
    @State var healthDataTypes = [HKQuantityTypeIdentifier]()
    @Binding var dataTypes: [String]
    @State var target = ""
    @State var target2 = ""
    
    let healthStore = HKHealthStore()
    
    @State var chartData = [MultiLineChartData]()
    
    @State var ready = true
    
    @State var refresh = false
    
    @State var healthTarget = HKQuantityTypeIdentifier.walkingDoubleSupportPercentage
    @State var healthTarget2 = HKQuantityTypeIdentifier.walkingSpeed
    
    @State var rValue = 0.0
    
    @State var qualityOfModel = 21
    
    var body: some View {
        ZStack {
            Color(qualityOfModel == 0 ? .systemGreen : qualityOfModel == 1 ? .systemYellow : qualityOfModel == 2 ? .systemRed : .clear)
                .ignoresSafeArea()
            .onAppear() {
                let types: [HKQuantityTypeIdentifier] = [.walkingStepLength, .walkingSpeed, .walkingAsymmetryPercentage, .walkingDoubleSupportPercentage]
                healthDataTypes = types
    
                

               
            }
            if ready {
                VStack {
                    HStack {
                        Menu {
                            
                           
                                
                                ForEach(dataTypes, id: \.self) { tag in
                                    Button(action: {
                                        refresh = true
                                        target = tag
                                        trainCompareOnDevice(userData: userData, target: tag, target2: target2) { (value) in
                                            rValue = value.accuracy
                                            withAnimation(.easeInOut) {
                                            if rValue < 0.15  {
                                            qualityOfModel = 0
                                                
                                            } else if rValue > 0.15 && rValue < 0.3 {
                                                qualityOfModel = 1
                                            } else if rValue > 0.3 {
                                                qualityOfModel = 2
                                            }
                                            }
                                            chartData.append(MultiLineChartData(points: value.predicted, gradient: .init(start: Color("teal"), end: Color("teal"))))
                                            chartData.append(MultiLineChartData(points: value.actual, gradient: .init(start: Color("blue"), end: Color("blue"))))
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                withAnimation(.easeInOut) {
                                              
                                                }
                                            refresh = false
                                            }
                                        }
                                    }) {
                                    
                                        Text(tag.replacingOccurrences(of: "HKQuantityTypeIdentifier", with: ""))
                                            .font(.custom("Montserrat Bold", size: 12))
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(Color("Text"))
                                }
                            
                                           }
                    
                   
                  
                    
                       
                    }  label: {
                        Label("", systemImage: (healthTarget == .walkingSpeed ? SFSymbol.figureWalk : healthTarget == .walkingDoubleSupportPercentage ? SFSymbol.scalemass : healthTarget == .walkingStepLength ? SFSymbol.ruler : healthTarget == .walkingAsymmetryPercentage ? SFSymbol.scalemassFill : .circle).rawValue).frame(width: 75).foregroundColor(Color(qualityOfModel == 21 ? .systemBlue : .white))
                    }
                        Spacer()
                        
                        Menu {
                            
                           
                                
                                ForEach(dataTypes, id: \.self) { tag in
                                    Button(action: {
                                        target2 = tag
                                        refresh = true
                                        trainCompareOnDevice(userData: userData, target: target, target2: tag) { (value) in
                                            rValue = value.accuracy
                                            withAnimation(.easeInOut) {
                                            if rValue < 0.15  {
                                            qualityOfModel = 0
                                                
                                            } else if rValue > 0.15 && rValue < 0.3 {
                                                qualityOfModel = 1
                                            } else if rValue > 0.3 {
                                                qualityOfModel = 2
                                            }
                                            }
                                            chartData.append(MultiLineChartData(points: value.predicted, gradient: .init(start: Color("teal"), end: Color("teal"))))
                                            chartData.append(MultiLineChartData(points: value.actual, gradient: .init(start: Color("blue"), end: Color("blue"))))
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            refresh = false
                                               
                                            }
                                            
                                        }
                                    }) {
                                    
                                        Text(tag.replacingOccurrences(of: "HKQuantityTypeIdentifier", with: ""))
                                            .font(.custom("Montserrat Bold", size: 12))
                                        .multilineTextAlignment(.leading)
                                        
                                }
                            
                                           }
                    
                   
                   
                    
                       
                    }  label: {
                        Label("", systemImage: (healthTarget2 == .walkingSpeed ? SFSymbol.figureWalk : healthTarget2 == .walkingDoubleSupportPercentage ? SFSymbol.scalemass : healthTarget2 == .walkingStepLength ? SFSymbol.ruler : healthTarget2 == .walkingAsymmetryPercentage ? SFSymbol.scalemassFill : .circle).rawValue).frame(width: 75)  .foregroundColor(Color(qualityOfModel == 21 ? .systemBlue : .white))
                    }
                    }
                    HStack {
                        Text("Model r Score: ")
                            .foregroundColor(Color(qualityOfModel == 21 ? .darkText : .white))
                        Spacer()
                        Text(String(rValue))
                            .foregroundColor(Color(qualityOfModel == 21 ? .darkText : .white))
                    }
                    if !refresh {
                    //MultiLineChartView(data: $chartData, refresh: $refresh, title: "")
                    }
                  //      .padding()
                    Spacer()
                } .padding()
        }
            if qualityOfModel != 21 {
                Text(qualityOfModel == 0 ? "Great Correlation" : qualityOfModel == 1 ? "Decent Correlation" : qualityOfModel == 2 ? "Little Correlation" : "")
                    .foregroundColor(.white)
            }
        }
    }
    
    func getHealthData(type: HKQuantityTypeIdentifier, dateDistanceType: DateDistanceType, dateDistance: Int, completionHandler: @escaping ([UserData]) -> Void) {
        var data = [UserData]()
        let calendar = NSCalendar.current
        var anchorComponents = calendar.dateComponents([.day, .month, .year, .weekday], from: NSDate() as Date)
        
        let offset = (7 + anchorComponents.weekday! - 2) % 7
        
        anchorComponents.day! -= offset
        anchorComponents.hour = 2
        
        guard let anchorDate = Calendar.current.date(from: anchorComponents) else {
            fatalError("*** unable to create a valid date from the given components ***")
        }
        
        let interval = NSDateComponents()
        interval.minute = 30
        
        let endDate = Date()
        
        guard let startDate = calendar.date(byAdding: (dateDistanceType == .Week ? .day : .month), value: -dateDistance, to: endDate) else {
            fatalError("*** Unable to calculate the start date ***")
        }
        guard let quantityType3 = HKObjectType.quantityType(forIdentifier: type) else {
            fatalError("*** Unable to create a step count type ***")
        }
        
        let query3 = HKStatisticsCollectionQuery(quantityType: quantityType3,
                                                 quantitySamplePredicate: nil,
                                                 options: [.discreteAverage],
                                                 anchorDate: anchorDate,
                                                 intervalComponents: interval as DateComponents)
        
        query3.initialResultsHandler = {
            query, results, error in
            
            if let statsCollection = results {
                
            
            
            statsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
              
                if let quantity = statistics.averageQuantity() {
                    let date = statistics.startDate
                    //for: E.g. for steps it's HKUnit.count()
                    let value = quantity.is(compatibleWith: .percent()) ? quantity.doubleValue(for: .percent()) : quantity.is(compatibleWith: .count()) ? quantity.doubleValue(for: .count()) : quantity.is(compatibleWith: .inch()) ? quantity.doubleValue(for: .inch()) : quantity.doubleValue(for: HKUnit.mile().unitDivided(by: HKUnit.hour()))
                    data.append(UserData(id: UUID().uuidString, type: .Health, title: type.rawValue, text: "", date: date, data: value))
                    userData.append(UserData(id: UUID().uuidString, type: .Health, title: type.rawValue, text: "", date: date, data: value))
                    print(type.rawValue)
                  
                    
    }
            
            }
                
        }
            
            completionHandler(data)
        }
        
        healthStore.execute(query3)
        
       
    }
    
    func trainCompareOnDevice(userData: [UserData], target: String, target2: String, completionHandler: @escaping (ModelResponse) -> Void) {
        var trainingData = DataFrame()
        let filteredToRemoveNan = userData.filter { data in
            return data.data.isNormal && !data.data.isNaN
        }
        let filteredToTarget = filteredToRemoveNan.filter { data in
            return data.type.rawValue == target || data.title == target
        }
        
        let filteredToTarget2 = filteredToRemoveNan.filter { data in
            return data.type.rawValue == target || data.title == target
        }
      
           print(filteredToTarget2)
           
            
          
                
               // print(trainingData.summary())
                var dataArray = filteredToTarget.map{Double($0.data)}
                var dataArray2 = filteredToTarget2.map{Double($0.data)}
        
                print(average(numbers: dataArray))
        let smallestCount = [dataArray.count, dataArray2.count].min() ?? 0
        let largestCount = [dataArray.count, dataArray2.count].max() ?? 0
        if dataArray.count > dataArray2.count {
            dataArray.removeLast(largestCount - smallestCount)
        }
        if dataArray.count < dataArray2.count {
            dataArray2.removeLast(largestCount - smallestCount)
        }
        var column = Column<Double>(name: target, capacity: smallestCount)
        column.append(contentsOf: dataArray)
       
        var column2 = Column<Double>(name: target2, capacity: smallestCount)
        column2.append(contentsOf: dataArray2)
        trainingData.append(column: column)
               
                trainingData.append(column: column2)
                    
                                
        
        

        let randomSplit = trainingData.randomSplit(by: 0.5)
        //print(randomSplit)
        let testingData = DataFrame(randomSplit.0)
        trainingData = DataFrame(randomSplit.1)
        do {
            let model = try MLRandomForestRegressor(trainingData: trainingData, targetColumn:  target)
           
           // try model.write(to: getDocumentsDirectory().appendingPathComponent(DataType.HappinessScore.rawValue + ".mlmodel"))
            print(model.trainingMetrics)
            print(model.validationMetrics)
            let predictions = try model.predictions(from: testingData)
            print(average(numbers: predictions.map{($0.unsafelyUnwrapped) as! Double}))
            let testingDataAsDouble =  trainingData.rows.map{$0.map{$0.unsafelyUnwrapped as! Double}}
           var doubleArray = [Double]()
            for data in testingDataAsDouble {
                doubleArray.append(contentsOf: data)
            }
            
           
            completionHandler(ModelResponse(type: target, predicted: predictions.map{($0.unsafelyUnwrapped) as! Double}, actual: doubleArray, accuracy: model.trainingMetrics.rootMeanSquaredError))
        } catch {
            print(error)

        }
       

    }
    func average(numbers: [Double]) -> Double {
        // print(numbers)
        return Double(numbers.reduce(0,+))/Double(numbers.count)
    }
}

