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
    var userData = [UserData(id: UUID().uuidString, type: .Habit, title: "", date: Date(), data: 0.0, goal: 0.0)]
    
    private var useCount = UserDefaults.standard.integer(forKey: "useCount")
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
     
       
        if useCount > 0 {
        
            let readData = Set([
                HKObjectType.quantityType(forIdentifier: .walkingSpeed)!,
                HKObjectType.quantityType(forIdentifier: .walkingStepLength)!,
                HKObjectType.quantityType(forIdentifier: .walkingDoubleSupportPercentage)!,
                HKObjectType.quantityType(forIdentifier: .walkingAsymmetryPercentage)!
            ])
            
            self.healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
                
                if success {
        
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
                            self.getHealthData()
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
             
                
            }
        }
                }
            }
        }
            
        return true
    }
    let healthStore = HKHealthStore()
    func getHealthData() {
        
        
        
        
        
        let readData = Set([
            HKObjectType.quantityType(forIdentifier: .walkingSpeed)!,
            HKObjectType.quantityType(forIdentifier: .walkingStepLength)!,
            HKObjectType.quantityType(forIdentifier: .walkingDoubleSupportPercentage)!
        ])
        
        healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
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
                            
                            //days = days.removeDuplicates()
                            
                            
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
    
//    func loadUsersExperiments(performAction: @escaping ([Experiment]) -> Void) {
//        let db = Firestore.firestore()
//        let docRef = db.collection("experiments")
//        var userList = [Experiment]()
//        let query = docRef.whereField("usersIDs", arrayContains: user.id.uuidString)
//        query.getDocuments { (documents, error) in
//            if !(documents?.isEmpty ?? true) {
//                for document in documents!.documents {
//                    let result = Result {
//                        try document.data(as: Experiment.self)
//                    }
//
//                    switch result {
//                    case .success(let user):
//                        if let user = user {
//                            userList.append(user)
//
//                        } else {
//
//                            print("Document does not exist")
//                        }
//                    case .failure(let error):
//                        print("Error decoding user: \(error)")
//                    }
//
//
//                }
//            }
//            performAction(userList)
//        }
//    }
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
                    
                    self.userData.append(UserData(id: UUID().uuidString, type: .Stride, title: "", date: date, data: value, goal: 0.0))
                    
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
                    
                    self.userData.append(UserData(id: UUID().uuidString, type: .WalkingSpeed, title: "", date: date, data: value, goal: 0.0))
                    
                    
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
                    
                    
                    
                    
                    self.userData.append(UserData(id: UUID().uuidString, type: .Balance, title: "", date: date, data: value, goal: 0.0))
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
                    if let today = components2.weekday {
                
                        self.userData.append(UserData(id: UUID().uuidString, type: .Asymmetry, title: "", date: date, data: value, goal: 0.0))
                    
                    
                }
                
                
            }
            
            
            //if (self.values.last ?? 0.0) - 11 > ((defaults.double(forKey: "avg")))  {
            
            
            
        }
            self.healthStore.execute(query4)
    }
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

