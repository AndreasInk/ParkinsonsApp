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
    @State var animate = false
    @State var animate2 = false
    @State var ready = true
    //@State var days = [Day]()
    @State var habitsUserData = [UserData(id: UUID().uuidString, type: .Habit, title: "", text: "", date: Date(), data: 0.0)]
    @State var values = [Double]()
   @State var isTutorial = false
     
    @State var settings =  [Setting(title: "Notifications", text: "We'll send notifications to remind you to keep your phone in your pocket to gain insights and send updates on habits", onOff: true, dates: [9]), Setting(title: "Accessability", text: "Enable these features to make it easier to use the app", onOff: true), Setting(title: "Customize Your Widget", text: "You track your score on your home screen with widgets", onOff: true)]

    @State private var useCount = UserDefaults.standard.integer(forKey: "useCount")

    @State var userData = [UserData]()
    @State var isOnboarding: Bool =  false
    @State var isOnboarding2: Bool =  false
    
    @State var healthDataTypes = [HKQuantityTypeIdentifier]()
    var body: some View {
        ZStack {
            Color.clear
                .onAppear() {
                   
                    if useCount == 0 {
                        #warning("disabled")
//                        isOnboarding = true
//                        isOnboarding2 = true
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
                .onAppear() {
                    
                   
                    let url = self.getDocumentsDirectory().appendingPathComponent("userData.txt")
                    do {
                        
                        let input = try String(contentsOf: url)
                        
                        
                        let jsonData = Data(input.utf8)
                        do {
                            let decoder = JSONDecoder()
                            
                            do {
                                let note = try decoder.decode([UserData].self, from: jsonData)
                               
                                userData = note
                       
                                
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
                               
                              
                                
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    } catch {
                        print(error.localizedDescription)
                        
                    }
                    let url3 = self.getDocumentsDirectory().appendingPathComponent("habitsUserData.txt")
                    do {
                        
                        let input = try String(contentsOf: url3)
                        
                        
                        let jsonData = Data(input.utf8)
                        do {
                            let decoder = JSONDecoder()
                            
                            do {
                                let note = try decoder.decode([UserData].self, from: jsonData)
                                
                                habitsUserData = note
                                print(note)
                             
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    } catch {
                        
                    }
                    healthDataTypes.append(contentsOf: [.walkingStepLength, .walkingSpeed, .walkingAsymmetryPercentage, .walkingDoubleSupportPercentage])
                    let readData = Set(
                        healthDataTypes.map{HKObjectType.quantityType(forIdentifier: $0)!}
                    )
                    
                    self.healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
                        
                        
                    }
                    for type in healthDataTypes {
                       
                        getHealthData(type: type, dateDistanceType: .Month, dateDistance: 12) { (healthValues) in
                           
                            let filteredToSpecificHealthTitle = healthValues.filter { data in
                                return data.title == type.rawValue
                            }
                            
                              
                           
                            ready = true
                            animate2 = true
                           // userData = healthValues
                        }
                       
                    }
                    
                    if !isOnboarding {
                   
                    } else {
                        ready = true
                        animate2 = true
                    }

                }
            if animate {
             
                EmptyView()
                    .transition(.opacity)
            }
            if animate2 {
                Color.clear
                    .ignoresSafeArea()
                
                HomeView(userData: $userData, isTutorial: $isTutorial, settings2: $settings, habitsUserData: $habitsUserData)
                    .transition(.opacity)
                    
                    .onChange(of: userData, perform: { value in
                        let filtered = userData.filter { data in
                                                      
                            return data.type == .Habit || data.type == .Meds ||  data.type == .Score
                                                            }
                        let encoder = JSONEncoder()
                        if let encoded = try? encoder.encode(filtered) {
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
                
                    .onChange(of: habitsUserData, perform: { value in
                        
                        let encoder = JSONEncoder()
                        if let encoded = try? encoder.encode(habitsUserData) {
                            if let json = String(data: encoded, encoding: .utf8) {
                              
                                do {
                                    let url = self.getDocumentsDirectory().appendingPathComponent("habitsUserData.txt")
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
                for type in healthDataTypes {
                   
                    getHealthData(type: type, dateDistanceType: .Month, dateDistance: 12) { (healthValues) in
                    }
                }
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
                    //data.append(UserData(id: UUID().uuidString, type: .Balance, title: type.rawValue, text: "", date: date, data: value))
                    userData.append(UserData(id: UUID().uuidString, type: type == .walkingSpeed ? .WalkingSpeed : type == .walkingDoubleSupportPercentage ? .Balance : .Stride, title: type.rawValue, text: "", date: date, data: value))
                    print(type.rawValue)
                  
                    
    }
            
            }
                
        }
            
            completionHandler(data)
        }
        
        healthStore.execute(query3)
        
       
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

