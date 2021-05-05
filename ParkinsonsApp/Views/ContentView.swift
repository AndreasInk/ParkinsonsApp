//
//  ContentView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI
import HealthKit
import CoreMotion
import FirebaseFirestoreSwift
import FirebaseFirestore
struct ContentView: View {
    @State var animate = true
    @State var animate2 = false
    @State var ready = false
    @State var days = [Day]()
  
    @State var values = [Double]()
    
    @State var week = Week(id: UUID().uuidString,  sun: Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date(), totalScore: 0.0), mon:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](),  walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date(), totalScore: 0.0), tue:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date(), totalScore: 0.0), wed:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date(), totalScore: 0.0), thur:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date(), totalScore: 0.0), fri:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date(), totalScore: 0.0), sat:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date(), totalScore: 0.0))
    let model = reg_model()
    
    @State var user = User(id: UUID(), name: "Steve", experiments: [Experiment](), createdExperiments: [Experiment](), posts: [Post]())
    var body: some View {
        ZStack {
            Color.white
            .ignoresSafeArea()
            .onAppear() {
                let url = self.getDocumentsDirectory().appendingPathComponent("user.txt")
                do {
                   
                    let input = try String(contentsOf: url)
                    
                   
                    let jsonData = Data(input.utf8)
                    do {
                        let decoder = JSONDecoder()

                        do {
                            let note = try decoder.decode(User.self, from: jsonData)
                            
                            user = note
//                                if i.first!.id == "1" {
//                                    notes.removeFirst()
//                                }
                           
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                } catch {
                    
                }
                
                getHealthData()
                if ready {
                let url = self.getDocumentsDirectory().appendingPathComponent("data2.txt")
                do {
                   
                    let input = try String(contentsOf: url)
                    
                   
                    let jsonData = Data(input.utf8)
                    do {
                        let decoder = JSONDecoder()

                        do {
                            let note = try decoder.decode([Day].self, from: jsonData)
                            
                            let filtered = note.filter { day in
                                return Date().addingTimeInterval(-604800) > day.date
                            }
                            days = filtered
                            
                            
                            days =  days.removeDuplicates()
                            print(days.count)
//                                if i.first!.id == "1" {
//                                    notes.removeFirst()
//                                }
                           
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                } catch {
                    print(error.localizedDescription)
                    
                }
            } catch {
                print(error.localizedDescription)
                
            }
               
                
                  
            
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 1.5)) {
                    animate = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                        withAnimation(.easeInOut(duration: 1.5)) {
                            let sumArray = self.values.reduce(0, +)
                            let avgArrayValue = (sumArray) / Double(self.values.count)
                            print(avgArrayValue)
                          
                        }
                    }
                }
               
                
                }
            }
        if animate {
           // LoadingView()
            EmptyView()
                .transition(.opacity)
        }
            if animate2 {
                Color.white
                    .ignoresSafeArea()
               
                HomeView(week: $week, days: $days, user: $user)
                    .transition(.opacity)
                     
                        .onChange(of: days, perform: { value in
                            let encoder = JSONEncoder()
                            days = days.removeDuplicates()
                            if let encoded = try? encoder.encode(days.removeDuplicates()) {
                                if let json = String(data: encoded, encoding: .utf8) {
                                    print(json)
                                    do {
                                        let url = self.getDocumentsDirectory().appendingPathComponent("data2.txt")
                                        try json.write(to: url, atomically: false, encoding: String.Encoding.utf8)
                                    
                                    } catch {
                                        print("erorr")
                                    }
                                }

                               
                            }
                            
                        })
                    
            
            }
        }
        
    }
    func getLocalScore(double: Double, speed: Double, length: Double, completionHandler: @escaping (PredictedScore) -> Void) {
        if double.isNormal {
        do {
            let prediction =  try self.model.prediction(double_: double, speed: speed, length: length)
            completionHandler(PredictedScore(prediction: prediction.sourceName, predicted_parkinsons: prediction.sourceName > 0.5 ? 1 : 0))
        } catch {

        }
        } else {
            completionHandler(PredictedScore(prediction: 21.0, predicted_parkinsons: 21))
        }
    }
    
    let healthStore = HKHealthStore()
    func getHealthData() {
        
        
        let defaults = UserDefaults.standard
       
       
        let readData = Set([
            HKObjectType.quantityType(forIdentifier: .walkingSpeed)!,
            HKObjectType.quantityType(forIdentifier: .walkingStepLength)!,
            HKObjectType.quantityType(forIdentifier: .walkingDoubleSupportPercentage)!
        ])
      
        healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
            if success {
        if HKHealthStore.isHealthDataAvailable() {
        let readType = HKObjectType.quantityType(forIdentifier: .walkingDoubleSupportPercentage)
            
            let url = self.getDocumentsDirectory().appendingPathComponent("data.txt")
            do {
               
                let input = try String(contentsOf: url)
                
               
                let jsonData = Data(input.utf8)
                do {
                    let decoder = JSONDecoder()

                    do {
                        
                       
                    } catch {
                        print(error.localizedDescription)
                    }
            } catch {
                print(error.localizedDescription)
                
            }
        } catch {
            print(error.localizedDescription)
            
        }
            print("Values")
           
       
                    let readData = Set([
                        HKObjectType.quantityType(forIdentifier: .walkingSpeed)!,
                        HKObjectType.quantityType(forIdentifier: .walkingStepLength)!,
                        HKObjectType.quantityType(forIdentifier: .walkingDoubleSupportPercentage)!,
                        HKObjectType.quantityType(forIdentifier: .walkingAsymmetryPercentage)!
                    ])
                   
                    healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
                        if success {
                           
                            
                            getDouble()
                           
                            getAsym()
                            
                            getSpeed()
                            
                            getLength()
                          
                            days = days.removeDuplicates()
                            
                            
                        } else {
                            print("Authorization failed")
animate2 = true
                        }
                  
          //  completionHandler()
                
        
            
        
        // defaults?.set(try? PropertyListEncoder().encode(data), forKey:"data")
       
            }
           
        }
        //defaults?.set(dates, forKey: "dates")
      
       
               
        //defaults?.set(self.values.reduce(0, +)/Double(self.values.count), forKey: "avg")
        //WidgetCenter.shared.reloadAllTimelines()
    }
        }
       
        ready = true
    }

        
        func getLength() {
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
                                        
            guard let startDate = calendar.date(byAdding: .day, value: -6, to: endDate) else {
                fatalError("*** Unable to calculate the start date ***")
            }
            guard let quantityType3 = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.walkingStepLength) else {
                fatalError("*** Unable to create a step count type ***")
            }

            let query3 = HKStatisticsCollectionQuery(quantityType: quantityType3,
                                                    quantitySamplePredicate: nil,
                                                    options: .discreteAverage,
                                                        anchorDate: anchorDate,
                                                        intervalComponents: interval as DateComponents)
           
            query3.initialResultsHandler = {
                query, results, error in
                
                guard let statsCollection = results else {
                    fatalError("*** An error occurred while calculating the statistics: \(String(describing: error?.localizedDescription)) ***")
                    
                }
               
                statsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                    if let quantity = statistics.averageQuantity() {
                        let date = statistics.startDate
                        //for: E.g. for steps it's HKUnit.count()
                        let value = quantity.doubleValue(for: HKUnit.inch())
                      //  self.week.mon.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                        let today = date.get(.weekday)
                            
                        //print(value)
                           
                         //   if "\(today)" + "\(month)" + "\(year)" == "\(today)" + "\(month2)" + "\(year2)" {
                                if today == 0 {
                                    self.week.mon.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                                } else if today == 1 {
                                    
                                    self.week.tue.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                                    
                                } else if today == 2 {
                                    self.week.wed.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                                } else if today == 3 {
                                    self.week.thur.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                                }  else if today == 4 {
                                    self.week.fri.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                                }  else if today == 5 {
                                    self.week.sat.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                            } else if today == 6 {
                                self.week.sun.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                            
                        }
                      //  }
                       
                        //print(date)
                        
                       
                       // dates = defaults?.array(forKey: "dates") as? [Date] ?? []
//                                        self.values.append(value)
//                                        self.dates.append(date)
//
//
//                                        defaults?.set(self.values, forKey: "values")
//                                        defaults?.set(self.dates, forKey: "dates")
//                                        defaults?.set(self.values.last ?? 0.0, forKey: "last")
//
//
//                                        WidgetCenter.shared.reloadAllTimelines()
//                        print("avg")
//                        print((defaults.double(forKey: "avg") ?? 0.0) )
//
                       
                       
                    }
                   
                    
                }
                
             
                //if (self.values.last ?? 0.0) - 11 > ((defaults.double(forKey: "avg")))  {
               
             
            
                
                    
                    animate2 = true
           
        }
            healthStore.execute(query3)
            
}
    func getSpeed() {
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
                                    
        guard let startDate = calendar.date(byAdding: .day, value: -6, to: endDate) else {
            fatalError("*** Unable to calculate the start date ***")
        }
                            
        guard let quantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.walkingSpeed) else {
            fatalError("*** Unable to create a step count type ***")
        }

        let query = HKStatisticsCollectionQuery(quantityType: quantityType,
                                                quantitySamplePredicate: nil,
                                                options: .discreteAverage,
                                                    anchorDate: anchorDate,
                                                    intervalComponents: interval as DateComponents)
        
        query.initialResultsHandler = {
            query, results, error in
            
            guard let statsCollection = results else {
                fatalError("*** An error occurred while calculating the statistics: \(String(describing: error?.localizedDescription)) ***")
                
            }
                                
            statsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                if let quantity = statistics.averageQuantity() {
                    let date = statistics.startDate
                    //for: E.g. for steps it's HKUnit.count()
                    let value = quantity.doubleValue(for: HKUnit.mile().unitDivided(by: HKUnit.hour()))
                  //  self.week.mon.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
                    let today = date.get(.weekday)
                       // print("Value")
                   // print(statsCollection)
                       
                        
                            if today == 0 {
                                self.week.mon.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
                            } else if today == 1 {
                                
                                self.week.tue.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
                                
                            } else if today == 2 {
                                self.week.wed.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
                            } else if today == 3 {
                                self.week.thur.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
                            }  else if today == 4 {
                                self.week.fri.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
                            }  else if today == 5 {
                                self.week.sat.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
                        } else if today == 6 {
                            self.week.sun.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
                       
                    }
                   // print(quantity)
                   
                   
                    //print(date)
                    
                   
                   // dates = defaults?.array(forKey: "dates") as? [Date] ?? []
//                                        self.values.append(value)
//                                        self.dates.append(date)
//
//
//                                        defaults?.set(self.values, forKey: "values")
//                                        defaults?.set(self.dates, forKey: "dates")
//                                        defaults?.set(self.values.last ?? 0.0, forKey: "last")
//
//
//                                        WidgetCenter.shared.reloadAllTimelines()
                  //  print("avg")
                   
                    
                   
                   
                }
               
                
            }
            
         
            //if (self.values.last ?? 0.0) - 11 > ((defaults.double(forKey: "avg")))  {
        
       
        }
        healthStore.execute(query)
    }
    

    
    func getDouble() {
        
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
                                    
        guard let startDate = calendar.date(byAdding: .day, value: -6, to: endDate) else {
            fatalError("*** Unable to calculate the start date ***")
        }
        
        guard let quantityType2 = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.walkingDoubleSupportPercentage) else {
            fatalError("*** Unable to create a step count type ***")
        }

        let query2 = HKStatisticsCollectionQuery(quantityType: quantityType2,
                                                quantitySamplePredicate: nil,
                                                options: .discreteAverage,
                                                    anchorDate: anchorDate,
                                                    intervalComponents: interval as DateComponents)
        
        query2.initialResultsHandler = {
            query, results, error in
            
            guard let statsCollection = results else {
                fatalError("*** An error occurred while calculating the statistics: \(String(describing: error?.localizedDescription)) ***")
                
            }
                                
            statsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                if let quantity = statistics.averageQuantity() {
                    let date = statistics.startDate
                    //for: E.g. for steps it's HKUnit.count()
                    let value = quantity.doubleValue(for: HKUnit.percent())
                    values.append(value*100)
                   // self.week.mon.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                   // print(quantity)
                   // self.week.mon.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                    
                    let today = date.get(.weekday)
                    
                         
                        
                   
                       
                        //if "\(today)" + "\(month)" + "\(year)" == "\(today)" + "\(month2)" + "\(year2)" {
                  //  print(value)
                    
                      
                            if today == 0 {
                                self.week.mon.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                                print(self.week)
                            } else if today == 1 {
                                
                                self.week.tue.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                                
                            } else if today == 2 {
                                self.week.wed.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                            } else if today == 3 {
                                self.week.thur.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                            }  else if today == 4 {
                                self.week.fri.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                            }  else if today == 5 {
                                self.week.sat.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                        } else if today == 6 {
                            self.week.sun.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                        
                   // }
                    }
                    //print(date)
                    
                   
                   // dates = defaults?.array(forKey: "dates") as? [Date] ?? []
//                                        self.values.append(value)
//                                        self.dates.append(date)
//
//
//                                        defaults?.set(self.values, forKey: "values")
//                                        defaults?.set(self.dates, forKey: "dates")
//                                        defaults?.set(self.values.last ?? 0.0, forKey: "last")
//
//
//                                        WidgetCenter.shared.reloadAllTimelines()
//                    print("avg")
//                    print((defaults.double(forKey: "avg") ?? 0.0) )
//
                   
                   
                }
               
                
            }
            
           
            //if (self.values.last ?? 0.0) - 11 > ((defaults.double(forKey: "avg")))  {
        }
        healthStore.execute(query2)
    }
    
    func getAsym() {
        
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
                                    
        guard let startDate = calendar.date(byAdding: .day, value: -6, to: endDate) else {
            fatalError("*** Unable to calculate the start date ***")
        }
        guard let quantityType4 = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.walkingAsymmetryPercentage) else {
            fatalError("*** Unable to create a step count type ***")
        }

        let query4 = HKStatisticsCollectionQuery(quantityType: quantityType4,
                                                quantitySamplePredicate: nil,
                                                options: .discreteAverage,
                                                    anchorDate: anchorDate,
                                                    intervalComponents: interval as DateComponents)
        
        query4.initialResultsHandler = {
            query, results, error in
            
            guard let statsCollection = results else {
                fatalError("*** An error occurred while calculating the statistics: \(String(describing: error?.localizedDescription)) ***")
                
            }
                                
            statsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                if let quantity = statistics.averageQuantity() {
                    let date = statistics.startDate
                    //for: E.g. for steps it's HKUnit.count()
                    let value = quantity.doubleValue(for: HKUnit.percent())
                    values.append(value*100)
                   // print(quantity)
                   // self.week.mon.aysm.append(Asymmetry(id: UUID().uuidString, asym: value, date: date))
                    let components = Date().get(.weekday, .month, .year)
                    let components2 = date.get(.weekday, .month, .year)
                    if let today = components2.weekday, let month = components.month, let year = components.year {
                    if let today2 = components.weekday, let month2 = components.month, let year2 = components.year {
                        
                    //print(value)
                       
                    //    if "\(today)" + "\(month)" + "\(year)" == "\(today)" + "\(month2)" + "\(year2)" {
                       
                  //  print(value)
                    
                       
                            if today == 0 {
                                print(self.week)
                                
                            } else if today == 1 {
                                
                                self.week.tue.aysm.append(Asymmetry(id: UUID().uuidString, asym: value, date: date))
                                
                            } else if today == 2 {
                                self.week.wed.aysm.append(Asymmetry(id: UUID().uuidString, asym: value, date: date))
                            } else if today == 3 {
                                self.week.thur.aysm.append(Asymmetry(id: UUID().uuidString, asym: value, date: date))
                            }  else if today == 4 {
                                self.week.fri.aysm.append(Asymmetry(id: UUID().uuidString, asym: value, date: date))
                            }  else if today == 5 {
                                self.week.sat.aysm.append(Asymmetry(id: UUID().uuidString, asym: value, date: date))
                        } else if today == 6 {
                            self.week.sun.aysm.append(Asymmetry(id: UUID().uuidString, asym: value, date: date))
                        }
                        }
                  //  }
                    }
                    //print(date)
                    
                   
                   // dates = defaults?.array(forKey: "dates") as? [Date] ?? []
//                                        self.values.append(value)
//                                        self.dates.append(date)
//
//
//                                        defaults?.set(self.values, forKey: "values")
//                                        defaults?.set(self.dates, forKey: "dates")
//                                        defaults?.set(self.values.last ?? 0.0, forKey: "last")
//
//
//                                        WidgetCenter.shared.reloadAllTimelines()
//                    print("avg")
//                    print((defaults.double(forKey: "avg") ?? 0.0) )
                    
                   
                   
                }
               
                
            }
            
         
            //if (self.values.last ?? 0.0) - 11 > ((defaults.double(forKey: "avg")))  {
          
        
        
    }
        healthStore.execute(query4)
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

