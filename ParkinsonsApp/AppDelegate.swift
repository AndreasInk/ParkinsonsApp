//
//  AppDelegate.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import UIKit
import Firebase
import HealthKit
import WidgetKit
import CoreML
import NiceNotifications
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var week = Week(id: UUID().uuidString,  sun: Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), mon:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), tue:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), wed:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), thur:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), fri:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), sat:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()))
    
  
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
     
       
       
        
        let readData = Set([
            HKObjectType.quantityType(forIdentifier: .walkingSpeed)!,
            HKObjectType.quantityType(forIdentifier: .walkingStepLength)!,
            HKObjectType.quantityType(forIdentifier: .walkingDoubleSupportPercentage)!,
            HKObjectType.quantityType(forIdentifier: .walkingAsymmetryPercentage)!
        ])
        
        self.healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
            
        }
        
        let healthStore = HKHealthStore()
        let readType2 = HKObjectType.quantityType(forIdentifier: .walkingDoubleSupportPercentage)
        healthStore.enableBackgroundDelivery(for: readType2!, frequency: .immediate) { success, error in
            if !success {
                print("Error enabling background delivery for type \(readType2!.identifier): \(error.debugDescription)")
            } else {
                print("Success enabling background delivery for type \(readType2!.identifier)")
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
                            if today == 1 {
                                self.week.mon.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                            } else if today == 2 {
                                
                                self.week.tue.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                                
                            } else if today == 3 {
                                self.week.wed.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                            } else if today == 4 {
                                self.week.thur.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                            }  else if today == 5 {
                                self.week.fri.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                            }  else if today == 6 {
                                self.week.sat.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                            } else if today == 0 {
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
                    
                    
                    
                    
                    
                    
                    
                }
                healthStore.execute(query3)
                self.getHealthData()
                if Date().get(.day) == 0 {
                    let double = self.week.sun.balance.map({ $0.value })
                    let speed = self.week.sun.walkingSpeed.map({ $0.speed })
                    let length = self.week.sun.strideLength.map({ $0.length })
                    self.getLocalScore(double: self.average(numbers: double), speed: self.average(numbers: speed), length: self.average(numbers: length)) { (score) in
                        
                        if score.prediction != 21.0 {
                            UserDefaults(suiteName: "group.parkinsonsappv2.app")?.setValue(score.prediction, forKey: "lastScore")
                            let avg = UserDefaults(suiteName: "group.parkinsonsappv2.app")?.double(forKey: "averageScore") ?? 0.0
                            UserDefaults(suiteName: "group.parkinsonsappv2.app")?.setValue(self.average(numbers: [avg, score.prediction]), forKey: "averageScore")
                            if score.prediction == 1.0 {
                             
                                LocalNotifications.schedule(permissionStrategy: .askSystemPermissionIfNeeded) {
                                    EveryDay(forDays: 1, starting: .today)
                                        .at(hour: Date().get(.hour), minute: Date().get(.minute) + 1)
                                        .schedule(title: "Score Alert", body: "Your score is abnormally high")
                                }
                            }
                            WidgetCenter.shared.reloadAllTimelines()
                        }
                    }
                }
                if Date().get(.day) == 1 {
                    let double = self.week.mon.balance.map({ $0.value })
                    let speed = self.week.mon.walkingSpeed.map({ $0.speed })
                    let length = self.week.mon.strideLength.map({ $0.length })
                    self.getLocalScore(double: self.average(numbers: double), speed: self.average(numbers: speed), length: self.average(numbers: length)) { (score) in
                        if score.prediction != 21.0 {
                            UserDefaults(suiteName: "group.parkinsonsappv2.app")?.setValue(score.prediction, forKey: "lastScore")
                            let avg = UserDefaults(suiteName: "group.parkinsonsappv2.app")?.double(forKey: "averageScore") ?? 0.0
                            UserDefaults(suiteName: "group.parkinsonsappv2.app")?.setValue(self.average(numbers: [avg, score.prediction]), forKey: "averageScore")
                            
                            if score.prediction == 1.0 {
                             
                                LocalNotifications.schedule(permissionStrategy: .askSystemPermissionIfNeeded) {
                                    EveryDay(forDays: 1, starting: .today)
                                        .at(hour: Date().get(.hour), minute: Date().get(.minute) + 1)
                                        .schedule(title: "Score Alert", body: "Your score is abnormally high")
                                }
                            }
                            WidgetCenter.shared.reloadAllTimelines()
                        }
                    }
                }
                
                if Date().get(.day) == 2 {
                    let double = self.week.tue.balance.map({ $0.value })
                    let speed = self.week.tue.walkingSpeed.map({ $0.speed })
                    let length = self.week.tue.strideLength.map({ $0.length })
                    self.getLocalScore(double: self.average(numbers: double), speed: self.average(numbers: speed), length: self.average(numbers: length)) { (score) in
                        if score.prediction != 21.0 {
                            UserDefaults(suiteName: "group.parkinsonsappv2.app")?.setValue(score.prediction, forKey: "lastScore")
                            let avg = UserDefaults(suiteName: "group.parkinsonsappv2.app")?.double(forKey: "averageScore") ?? 0.0
                            UserDefaults(suiteName: "group.parkinsonsappv2.app")?.setValue(self.average(numbers: [avg, score.prediction]), forKey: "averageScore")
                            if score.prediction == 1.0 {
                             
                                LocalNotifications.schedule(permissionStrategy: .askSystemPermissionIfNeeded) {
                                    EveryDay(forDays: 1, starting: .today)
                                        .at(hour: Date().get(.hour), minute: Date().get(.minute) + 1)
                                        .schedule(title: "Score Alert", body: "Your score is abnormally high")
                                }
                            }
                            WidgetCenter.shared.reloadAllTimelines()
                        }
                    }
                }
                
                if Date().get(.day) == 3 {
                    let double = self.week.wed.balance.map({ $0.value })
                    let speed = self.week.wed.walkingSpeed.map({ $0.speed })
                    let length = self.week.wed.strideLength.map({ $0.length })
                    self.getLocalScore(double: self.average(numbers: double), speed: self.average(numbers: speed), length: self.average(numbers: length)) { (score) in
                        if score.prediction != 21.0 {
                            UserDefaults(suiteName: "group.parkinsonsappv2.app")?.setValue(score.prediction, forKey: "lastScore")
                            let avg = UserDefaults(suiteName: "group.parkinsonsappv2.app")?.double(forKey: "averageScore") ?? 0.0
                            UserDefaults(suiteName: "group.parkinsonsappv2.app")?.setValue(self.average(numbers: [avg, score.prediction]), forKey: "averageScore")
                            if score.prediction == 1.0 {
                             
                                LocalNotifications.schedule(permissionStrategy: .askSystemPermissionIfNeeded) {
                                    EveryDay(forDays: 1, starting: .today)
                                        .at(hour: Date().get(.hour), minute: Date().get(.minute) + 1)
                                        .schedule(title: "Score Alert", body: "Your score is abnormally high")
                                }
                            }
                            WidgetCenter.shared.reloadAllTimelines()
                        }
                    }
                }
                
                if Date().get(.day) == 4 {
                    let double = self.week.thur.balance.map({ $0.value })
                    let speed = self.week.thur.walkingSpeed.map({ $0.speed })
                    let length = self.week.thur.strideLength.map({ $0.length })
                    self.getLocalScore(double: self.average(numbers: double), speed: self.average(numbers: speed), length: self.average(numbers: length)) { (score) in
                        if score.prediction != 21.0 {
                            UserDefaults(suiteName: "group.parkinsonsappv2.app")?.setValue(score.prediction, forKey: "lastScore")
                            let avg = UserDefaults(suiteName: "group.parkinsonsappv2.app")?.double(forKey: "averageScore") ?? 0.0
                            UserDefaults(suiteName: "group.parkinsonsappv2.app")?.setValue(self.average(numbers: [avg, score.prediction]), forKey: "averageScore")
                            if score.prediction == 1.0 {
                             
                                LocalNotifications.schedule(permissionStrategy: .askSystemPermissionIfNeeded) {
                                    EveryDay(forDays: 1, starting: .today)
                                        .at(hour: Date().get(.hour), minute: Date().get(.minute) + 1)
                                        .schedule(title: "Score Alert", body: "Your score is abnormally high")
                                }
                            }
                            WidgetCenter.shared.reloadAllTimelines()
                        }
                    }
                }
                
                if Date().get(.day) == 5 {
                    let double = self.week.fri.balance.map({ $0.value })
                    let speed = self.week.fri.walkingSpeed.map({ $0.speed })
                    let length = self.week.fri.strideLength.map({ $0.length })
                    self.getLocalScore(double: self.average(numbers: double), speed: self.average(numbers: speed), length: self.average(numbers: length)) { (score) in
                        if score.prediction != 21.0 {
                            UserDefaults(suiteName: "group.parkinsonsappv2.app")?.setValue(score.prediction, forKey: "lastScore")
                            let avg = UserDefaults(suiteName: "group.parkinsonsappv2.app")?.double(forKey: "averageScore") ?? 0.0
                            UserDefaults(suiteName: "group.parkinsonsappv2.app")?.setValue(self.average(numbers: [avg, score.prediction]), forKey: "averageScore")
                            if score.prediction == 1.0 {
                             
                                LocalNotifications.schedule(permissionStrategy: .askSystemPermissionIfNeeded) {
                                    EveryDay(forDays: 1, starting: .today)
                                        .at(hour: Date().get(.hour), minute: Date().get(.minute) + 1)
                                        .schedule(title: "Score Alert", body: "Your score is abnormally high")
                                }
                            }
                            WidgetCenter.shared.reloadAllTimelines()
                        }
                    }
                }
                if Date().get(.day) == 6 {
                    let double = self.week.sat.balance.map({ $0.value })
                    let speed = self.week.sat.walkingSpeed.map({ $0.speed })
                    let length = self.week.sat.strideLength.map({ $0.length })
                    self.getLocalScore(double: self.average(numbers: double), speed: self.average(numbers: speed), length: self.average(numbers: length)) { (score) in
                        if score.prediction != 21.0 {
                            UserDefaults(suiteName: "group.parkinsonsappv2.app")?.setValue(score.prediction, forKey: "lastScore")
                            let avg = UserDefaults(suiteName: "group.parkinsonsappv2.app")?.double(forKey: "averageScore") ?? 0.0
                            UserDefaults(suiteName: "group.parkinsonsappv2.app")?.setValue(self.average(numbers: [avg, score.prediction]), forKey: "averageScore")
                            if score.prediction == 1.0 {
                             
                                LocalNotifications.schedule(permissionStrategy: .askSystemPermissionIfNeeded) {
                                    EveryDay(forDays: 1, starting: .today)
                                        .at(hour: Date().get(.hour), minute: Date().get(.minute) + 1)
                                        .schedule(title: "Score Alert", body: "Your score is abnormally high")
                                }
                            }
                            WidgetCenter.shared.reloadAllTimelines()
                        }
                    }
                }
                
                
            }
        }
        return true
    }
    let healthStore = HKHealthStore()
    func getHealthData() {
        
        
        
        print(1)
        
        let readData = Set([
            HKObjectType.quantityType(forIdentifier: .walkingSpeed)!,
            HKObjectType.quantityType(forIdentifier: .walkingStepLength)!,
            HKObjectType.quantityType(forIdentifier: .walkingDoubleSupportPercentage)!
        ])
        
        self.healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
            if success {
                if HKHealthStore.isHealthDataAvailable() {
                    
                    
                    
                   
                    
                    
                    let readData = Set([
                        HKObjectType.quantityType(forIdentifier: .walkingSpeed)!,
                        HKObjectType.quantityType(forIdentifier: .walkingStepLength)!,
                        HKObjectType.quantityType(forIdentifier: .walkingDoubleSupportPercentage)!,
                        HKObjectType.quantityType(forIdentifier: .walkingAsymmetryPercentage)!
                    ])
                    
                    self.healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
                        if success {
                            
                            
                            self.getDouble()
                            
                            self.getAsym()
                            
                            self.getSpeed()
                            
                            self.getLength()
                            
                            
                            
                            
                        } else {
                            print("Authorization failed")
                            
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
                    if today == 1 {
                        self.week.mon.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                    } else if today == 2 {
                        
                        self.week.tue.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                        
                    } else if today == 3 {
                        self.week.wed.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                    } else if today == 4 {
                        self.week.thur.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                    }  else if today == 5 {
                        self.week.fri.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                    }  else if today == 6 {
                        self.week.sat.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                    } else if today == 0 {
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
                    
                    
                    if today == 1 {
                        self.week.mon.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
                    } else if today == 2 {
                        
                        self.week.tue.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
                        
                    } else if today == 3 {
                        self.week.wed.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
                    } else if today == 4 {
                        self.week.thur.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
                    }  else if today == 5 {
                        self.week.fri.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
                    }  else if today == 6 {
                        self.week.sat.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
                    } else if today == 0 {
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
                    
                    // self.week.mon.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                    // print(quantity)
                    // self.week.mon.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                    
                    let today = date.get(.weekday)
                    
                    
                    
                    
                    
                    //if "\(today)" + "\(month)" + "\(year)" == "\(today)" + "\(month2)" + "\(year2)" {
                    //  print(value)
                    
                    
                    if today == 1 {
                        self.week.mon.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                       
                    } else if today == 2 {
                        
                        self.week.tue.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                        
                    } else if today == 3 {
                        self.week.wed.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                    } else if today == 4 {
                        self.week.thur.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                    }  else if today == 5 {
                        self.week.fri.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                    }  else if today == 6 {
                        self.week.sat.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                    } else if today == 0 {
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
                    
                    // print(quantity)
                    // self.week.mon.aysm.append(Asymmetry(id: UUID().uuidString, asym: value, date: date))
                    
                    let components2 = date.get(.weekday, .month, .year)
                    if let today = components2.weekday{
                        
                        
                        //print(value)
                        
                        //    if "\(today)" + "\(month)" + "\(year)" == "\(today)" + "\(month2)" + "\(year2)" {
                        
                        //  print(value)
                        
                        
                        if today == 1 {
                           
                            self.week.mon.aysm.append(Asymmetry(id: UUID().uuidString, asym: value, date: date))
                        } else if today == 2 {
                            
                            self.week.tue.aysm.append(Asymmetry(id: UUID().uuidString, asym: value, date: date))
                            
                        } else if today == 3 {
                            self.week.wed.aysm.append(Asymmetry(id: UUID().uuidString, asym: value, date: date))
                        } else if today == 4 {
                            self.week.thur.aysm.append(Asymmetry(id: UUID().uuidString, asym: value, date: date))
                        }  else if today == 5 {
                            self.week.fri.aysm.append(Asymmetry(id: UUID().uuidString, asym: value, date: date))
                        }  else if today == 6 {
                            self.week.sat.aysm.append(Asymmetry(id: UUID().uuidString, asym: value, date: date))
                        } else if today == 0 {
                            self.week.sun.aysm.append(Asymmetry(id: UUID().uuidString, asym: value, date: date))
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
    // MARK: UISceneSession Lifecycle
    func getLocalScore(double: Double, speed: Double, length: Double, completionHandler: @escaping (PredictedScore) -> Void) {
        
        if double.isNormal {
            do {
                let model = try reg_model(configuration: MLModelConfiguration())
                let prediction =  try model.prediction(double_: double, speed: speed, length: length)
                completionHandler(PredictedScore(prediction: prediction.sourceName, predicted_parkinsons: prediction.sourceName > 0.5 ? 1 : 0, date: Date()))
            } catch {
                
            }
        } else {
            completionHandler(PredictedScore(prediction: 21.0, predicted_parkinsons: 21, date: Date()))
        }
    }
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func average(numbers: [Double]) -> Double {
        // print(numbers)
        return Double(numbers.reduce(0,+))/Double(numbers.count)
    }
    
}

