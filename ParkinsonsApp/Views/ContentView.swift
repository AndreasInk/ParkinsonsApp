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
import CoreML
struct ContentView: View {
    @State var animate = true
    @State var animate2 = false
    @State var ready = false
    //@State var days = [Day]()
    
    @State var values = [Double]()
   @State var isTutorial = false
        //@State var week = Week(id: UUID().uuidString,  sun: Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), mon:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), tue:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), wed:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), thur:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), fri:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), sat:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()))
    @State var settings =  [Setting(title: "Notifications", text: "We'll send notifications to remind you to keep your phone in your pocket to gain insights and send updates on habits", onOff: true, dates: [9]), Setting(title: "Accessability", text: "Enable these features to make it easier to use the app", onOff: true), Setting(title: "Customize Your Widget", text: "You track your score on your home screen with widgets", onOff: true)]
    // Setting(title: "Share Your Experience", text: "By sharing your experience with the app, we can make it even better!  ", onOff: true), Setting(title: "Share Your Data", text: "By sharing your data, we can make scoring even better!  ", onOff: true), Setting(title: "Share With Your Doctor", text: "Export your data to your doctor to give important insights to your doctor to help you.", onOff: true)
    @State private var useCount = UserDefaults.standard.integer(forKey: "useCount")
   // @State var user = User(id: UUID(), name: "Steve", experiments: [Experiment](), createdExperiments: [Experiment](), posts: [Post](), habit: [Habit]())
    
    @State var userData = [UserData(id: UUID().uuidString, type: .Habit, date: Date(), data: 0.0)]
    @State var isOnboarding: Bool =  false
    @State var isOnboarding2: Bool =  false
    var body: some View {
        ZStack {
            Color.clear
                .onAppear() {
                   
                    if useCount == 0 {
                        isOnboarding = true
                        isOnboarding2 = true
                    } else {
                      
                        UserDefaults.standard.setValue(useCount + 1, forKey: "useCount")
                    }
                
           
        }
                .fullScreenCover(isPresented: $isOnboarding2, content: {
                    OnboardingView(isOnboarding: $isOnboarding, isOnboarding2: $isOnboarding2, setting: $settings[0])
                        .onDisappear() {
                            ready = true
                        }
                        
                })
                .ignoresSafeArea()
                .onDisappear() {
                    let encoder = JSONEncoder()
                    
                    if let encoded = try? encoder.encode(userData) {
                        if let json = String(data: encoded, encoding: .utf8) {
                          
                            do {
                                let url = self.getDocumentsDirectory().appendingPathComponent("userData.txt")
                                try json.write(to: url, atomically: false, encoding: String.Encoding.utf8)
                                
                            } catch {
                                print("erorr")
                            }
                        }
                        
                        
                    }
                }
                .onAppear() {
                    
                   
                    let url = self.getDocumentsDirectory().appendingPathComponent("user.txt")
                    do {
                        
                        let input = try String(contentsOf: url)
                        
                        
                        let jsonData = Data(input.utf8)
                        do {
                            let decoder = JSONDecoder()
                            
                            do {
                                let note = try decoder.decode([UserData].self, from: jsonData)
                                
                                userData = note
                                //                                if i.first!.id == "1" {
                                //                                    notes.removeFirst()
                                //                                }
                                
                                
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    } catch {
                        
                    }
                    let url2 = self.getDocumentsDirectory().appendingPathComponent("settings.txt")
                    do {
                        
                        let input = try String(contentsOf: url2)
                        
                        
                        let jsonData = Data(input.utf8)
                        do {
                            let decoder = JSONDecoder()
                            
                            do {
                                let note = try decoder.decode([Setting].self, from: jsonData)
                                
                                
                                
                                
                                settings =  note.removeDuplicates()
                               
                                //                                if i.first!.id == "1" {
                                //                                    notes.removeFirst()
                                //                                }
                                
                                
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    } catch {
                        print(error.localizedDescription)
                        
                    }
                    getHealthData()
                    if !isOnboarding {
                   
                    } else {
                        ready = true
                        animate2 = true
                    }
//                    if ready {
//                        let url = self.getDocumentsDirectory().appendingPathComponent("data2.txt")
//                        do {
//
//                            let input = try String(contentsOf: url)
//
//
//                            let jsonData = Data(input.utf8)
//                            do {
//                                let decoder = JSONDecoder()
//
//                                do {
//                                    let note = try decoder.decode([Day].self, from: jsonData)
//
//                                    let filtered = note.filter { day in
//                                        #warning("double check")
//                                        return Date().addingTimeInterval(-604800) > day.date
//                                    }
//                                    days = filtered
//
//
//                                    days =  days.removeDuplicates()
//
//                                    //                                if i.first!.id == "1" {
//                                    //                                    notes.removeFirst()
//                                    //                                }
//
//
//                                } catch {
//                                    print(error.localizedDescription)
//                                }
//                            }
//                        } catch {
//                            print(error.localizedDescription)
//
//                        }
//
//
//
//
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                            withAnimation(.easeInOut(duration: 1.5)) {
//                                animate = true
//                            }
//
//                        }
//
//
//                    }
//                    self.loadUsersExperiments() { experiments in
//                        self.user.experiments = experiments
                      //  print(experiments)
                       // #warning("Remove after testing")
                       // days.append(Day(id: UUID().uuidString, score: [Score(id: UUID().uuidString, score: 1.0, date: Date())], tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()))
                    //}
                }
            if animate {
                // LoadingView()
                EmptyView()
                    .transition(.opacity)
            }
            if animate2 {
                Color.clear
                    .ignoresSafeArea()
                
                HomeView(userData: $userData, isTutorial: $isTutorial, settings2: $settings)
                    .transition(.opacity)
                    .onAppear(){
                       
                    }
                    .onChange(of: userData, perform: { value in
                        let encoder = JSONEncoder()
                        if let encoded = try? encoder.encode(userData) {
                            if let json = String(data: encoded, encoding: .utf8) {
                              
                                do {
                                    let url = self.getDocumentsDirectory().appendingPathComponent("userData.txt")
                                    try json.write(to: url, atomically: false, encoding: String.Encoding.utf8)
                                    
                                } catch {
                                    print("erorr")
                                }
                            }
                            
                            
                        }
                    })
                 
                
                
            }
        } .onChange(of: isOnboarding, perform: { value in
            
            if !isOnboarding {
                animate2 = false
            getHealthData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                animate2 = true
                }
            }
        })
        
    }
    func saveExperiment(experiment: Experiment) {
        let db = Firestore.firestore()
        do {
            try db.collection("experiments").document(experiment.id.uuidString).setData(from: experiment)
            //print(experiment)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
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
                    
                    healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
                        if success {
                            
                            
                            getDouble()
                            
                            getAsym()
                            
                            getSpeed()
                            
                            getLength()
                            
                            //days = days.removeDuplicates()
                            
                            
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
                    
                    userData.append(UserData(id: UUID().uuidString, type: .Stride, date: date, data: value))
                    
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
                    
                    userData.append(UserData(id: UUID().uuidString, type: .WalkingSpeed, date: date, data: value))
                    
                    
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
                    
                    
                    
                    
                    userData.append(UserData(id: UUID().uuidString, type: .Balance, date: date, data: value))
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
                    
                    let components2 = date.get(.weekday, .month, .year)
                    if let today = components2.weekday {
                
                        userData.append(UserData(id: UUID().uuidString, type: .Balance, date: date, data: value))
                    
                    
                }
                
                
            }
            
            
            //if (self.values.last ?? 0.0) - 11 > ((defaults.double(forKey: "avg")))  {
            
            
            
        }
        healthStore.execute(query4)
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

