//
//  CardView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI
import CodableCSV
import HealthKit
import CoreML
import FirebaseStorage

struct CardView: View {
    @State var image = "doc"
    @State var text = "Share your data with your doctor"
    @State var cta = "Export Data"
    @Environment(\.presentationMode) var presentationMode
    @State var open = false
//    @State private var days = [Day]()
//    @State private var week = Week(id: UUID().uuidString,  sun: Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), mon:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), tue:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), wed:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), thur:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), fri:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), sat:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()))
//    @State private var balance = [Balance]()
//    @State private var length = [Stride]()
//    @State private var speed = [WalkingSpeed]()
//    @State private var score = [WalkingSpeed]()
    @State var userData = [UserData(id: UUID().uuidString, type: .Habit, date: Date(), data: 0.0)]
    private let healthStore = HKHealthStore()
    @State var loading = false
    @State var loaded =  false
    @State var progress = 0.0
    @State var premissionI = 0
    @State var q = false
    @State var canUse = false
    @State var hasParkinsons = false
    @State var done = false
    @Binding var openCard: Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color(.clear))
                .opacity(0.4)
//            VStack {
//                HStack {
//                Button(action: {
//
//                        openCard = false
//
//                }) {
//                   Image(systemName: "xmark")
//                    .font(.title)
//                } .buttonStyle(CTAButtonStyle())
//                    Spacer()
//                } .padding()
//
//                Spacer()
//
//                if !done {
//                HStack {
//                    Image(image)
//                        .resizable()
//                        .scaledToFit()
//                        .padding()
//
//                }
//                HStack {
//                    Text(text)
//                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .title))
//                        .foregroundColor(Color("blue"))
//                        .multilineTextAlignment(.center)
//                }
//                }
//                if loading {
//                    Text(done ? "Thank You!" : "This'll take a while, please wait")
//                        .multilineTextAlignment(.center)
//                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .title))
//                        .padding()
//                    if !done {
//                    ProgressView(value: progress)
//                    }
//                }
//                if done {
//                Spacer()
//                }
//                if !loading {
//                if !canUse {
//                if !done {
//                if cta != ""  {
//                    Spacer()
//                    HStack {
//                        Button(action: {
//                            if cta != "Export Data" && cta != "Share" {
//                                open = true
//                            }
//
//                            if  cta == "Share" {
//                                q = true
//                                loading = true
//
//                            } else if cta == "Export Data" {
//                                loading = true
//                                self.loadAllData() { experiments in
//                                    open = true
//                                }
//                            }
//
//                        }) {
//                            Text(cta)
//
//                                .font(.custom("Poppins-Bold", size: 18, relativeTo: .title))
//                                .foregroundColor(.white)
//                                .multilineTextAlignment(.center)
//                                .padding()
//                                .padding(.horizontal, 92)
//                                .background(RoundedRectangle(cornerRadius: 25.0).foregroundColor(Color("blue")))
//                        } .buttonStyle(CTAButtonStyle())
//
//                    }
//
//
//                }
//
//                }
//                }
//            } else {
//                Spacer()
//            }
//            }
//            .sheet(isPresented: $open) {
//                if cta == "Export Data" {
//                    ShareSheet(activityItems: [getDocumentsDirectory().appendingPathComponent("test.csv")])
//                        .onAppear() {
//                            progress = 1
//                        }
//                } else if cta == "Join" {
//                    ShareSheet(activityItems: ["Hello World"])
//
//                } else {
//                    ZStack {
//                    VStack {
//                        DismissSheetBtn()
//                        Spacer()
//                    Text("Thank You!")
//                        .font(.custom("Poppins-Bold", size: 24, relativeTo: .headline))
//                        .onDisappear() {
//                           openCard = false
//                        }
//                        Spacer()
//                    }
//                        ForEach(0 ..< 20) { number in
//                                            ConfettiView()
//                                            }
//                    }
//
//                }
//            }
//
//                if q {
//                    Color(.systemBackground)
//                        .ignoresSafeArea()
//                TabView(selection: $premissionI) {
//                    VStack {
//                        Text("Can We Include Your Data In The Model?")
//                            .font(.custom("Poppins-Bold", size: 18, relativeTo: .title))
//                            .multilineTextAlignment(.center)
//
//                        Button(action: {
//
//                            premissionI += 1
//                            print(premissionI)
//                            canUse = true
//                        }) {
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 25.0)
//                                    .foregroundColor(Color("teal"))
//                                    .frame(height: 75)
//                                    .padding()
//                                Text("Yes")
//                                    .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
//                                    .foregroundColor(.white)
//                            }
//                        } .buttonStyle(CTAButtonStyle())
//                        Button(action: {
//                            canUse = false
//                            q = false
//                        }) {
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 25.0)
//                                    .foregroundColor(Color(.lightGray))
//                                    .frame(height: 75)
//                                    .padding()
//                                Text("No")
//                                    .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
//                                    .foregroundColor(.white)
//                            }
//                        } .buttonStyle(CTAButtonStyle())
//                    } .tag(0)
//                    VStack {
//                        Text("Do You Have Parkinson's?")
//                            .font(.custom("Poppins-Bold", size: 18, relativeTo: .title))
//
//                        Button(action: {
//                            DispatchQueue.global(qos: .userInitiated).async {
//                            hasParkinsons = true
//                            if canUse {
//                                hasParkinsons = false
//                                loading = true
//
//                                loadAllData() { (score) in
//                                    if score {
//                                        if cta == "Share" {
//                                            let storage = Storage.storage()
//
//
//                                            let storageRef = storage.reference()
//
//                                            let riversRef = storageRef.child("data/\(UUID()).csv")
//
//                                            let encoder = JSONEncoder()
//                                            let url = getDocumentsDirectory().appendingPathComponent("test.csv")
//                                            do {
//
//                                                let input = try String(contentsOf: url)
//
//
//                                                let jsonData = Data(input.utf8)
//                                                do {
//                                                    let decoder = JSONDecoder()
//
//                                                    do {
//                                                    }
//
//                                                    let uploadTask = riversRef.putData(jsonData, metadata: nil) { (metadata, error) in
//                                                        guard let metadata = metadata else {
//                                                            // Uh-oh, an error occurred!
//                                                            return
//                                                        }
//
//                                                      //  presentationMode.wrappedValue.dismiss()
//
//
//                                                    }
//
//                                                } catch {
//                                                    print(error.localizedDescription)
//                                                }
//
//                                            } catch {
//
//                                            }
//
//
//
//
//
//                                        }
//                                        // Upload the file to the path "images/rivers.jpg"
//
//
//                                    }
//                                }
//                                q = false
//
//
//                            }
//
//                            }
//
//                        }) {
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 25.0)
//                                    .foregroundColor(Color("teal"))
//                                    .frame(height: 75)
//                                    .padding()
//                                Text("Yes")
//                                    .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
//                                    .foregroundColor(.white)
//                            }
//                        } .buttonStyle(CTAButtonStyle())
//                        Button(action: {
//
//                            DispatchQueue.global(qos: .userInitiated).async {
//                            if canUse {
//                                hasParkinsons = false
//                                loading = true
//                                loadAllData() { (score) in
//                                    if score {
//                                        if cta == "Share" {
//                                            let storage = Storage.storage()
//
//
//                                            let storageRef = storage.reference()
//
//                                            let riversRef = storageRef.child("data/\(UUID()).csv")
//
//                                            let encoder = JSONEncoder()
//                                            let url = getDocumentsDirectory().appendingPathComponent("test.csv")
//                                            do {
//
//                                                let input = try String(contentsOf: url)
//
//
//                                                let jsonData = Data(input.utf8)
//                                                do {
//                                                    let decoder = JSONDecoder()
//
//                                                    do {
//                                                    }
//
//                                                    let uploadTask = riversRef.putData(jsonData, metadata: nil) { (metadata, error) in
//                                                        guard let metadata = metadata else {
//                                                            // Uh-oh, an error occurred!
//                                                            return
//                                                        }
//
//                                                       // presentationMode.wrappedValue.dismiss()
//
//
//                                                    }
//
//                                                } catch {
//                                                    print(error.localizedDescription)
//                                                }
//
//                                            } catch {
//
//                                            }
//
//
//
//
//
//                                        }
//                                        // Upload the file to the path "images/rivers.jpg"
//
//
//                                    }
//                                }
//
//
//                                q = false
//
//                            }
//                            }
//
//                        }) {
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 25.0)
//                                    .foregroundColor(Color(.lightGray))
//                                    .frame(height: 75)
//                                    .padding()
//                                Text("No")
//                                    .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
//                                    .foregroundColor(.white)
//                            }
//                        } .buttonStyle(CTAButtonStyle())
//                    } .tag(1)
//                } .tabViewStyle(PageTabViewStyle())
//                }
//                if done {
//                    ForEach(0 ..< 20) { number in
//                                        ConfettiView()
//                                        }
//
//                }
//
//            } .padding(.horizontal)
//        .padding(.bottom)
//    }
//
//    func loadAllData(completionHandler: @escaping (Bool) -> Void) {
//        getHealthData() { (score) in
//            progress += 0.1
//            //print(days)
//            if score {
//                completionHandler(true)
//            }
//        }
//    }
//    func getLocalScore(double: Double, speed: Double, length: Double, completionHandler: @escaping (PredictedScore) -> Void) {
//
//            if double.isNormal {
//                do {
//                    let model = try reg_model(configuration: MLModelConfiguration())
//                    let prediction =  try model.prediction(double_: double, speed: speed, length: length)
//                    completionHandler(PredictedScore(prediction: prediction.sourceName, predicted_parkinsons: prediction.sourceName > 0.5 ? 1 : 0, date: Date()))
//
//                } catch {
//
//                }
//            } else {
//                completionHandler(PredictedScore(prediction: 21.0, predicted_parkinsons: 21, date: Date()))
//            }
//
//    }
//
//
//    func getHealthData(completionHandler: @escaping (Bool) -> Void) {
//
//
//
//
//
//        let readData = Set([
//            HKObjectType.quantityType(forIdentifier: .walkingSpeed)!,
//            HKObjectType.quantityType(forIdentifier: .walkingStepLength)!,
//            HKObjectType.quantityType(forIdentifier: .walkingDoubleSupportPercentage)!
//        ])
//
//        healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
//            if success {
//                if HKHealthStore.isHealthDataAvailable() {
//
//
//
//
//
//
//                    let readData = Set([
//                        HKObjectType.quantityType(forIdentifier: .walkingSpeed)!,
//                        HKObjectType.quantityType(forIdentifier: .walkingStepLength)!,
//                        HKObjectType.quantityType(forIdentifier: .walkingDoubleSupportPercentage)!,
//                        HKObjectType.quantityType(forIdentifier: .walkingAsymmetryPercentage)!
//                    ])
//
//                    healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
//                        if success {
//
//
//
//                            getDouble() { (score) in
//                                progress += 0.1
//
//                                getSpeed() { (score) in
//                                    progress += 0.1
//                                    getLength() { (score) in
//                                        progress += 0.3
//                                        days = days.removeDuplicates()
//
//                                        load() { (score) in
//                                            print("Loading")
//
//
//                                            completionHandler(true)
//                                            //  print(days)
//
//
//
//                                        }
//                                    }
//                                }
//
//                            }
//
//                        } else {
//                            print("Authorization failed")
//
//                        }
//
//                        //  completionHandler()
//
//
//
//
//                        // defaults?.set(try? PropertyListEncoder().encode(data), forKey:"data")
//
//                    }
//
//                }
//                //defaults?.set(dates, forKey: "dates")
//
//
//
//                //defaults?.set(self.values.reduce(0, +)/Double(self.values.count), forKey: "avg")
//                //WidgetCenter.shared.reloadAllTimelines()
//            }
//        }
//
//
//
//    }
//
//
//    func getLength() {
//        let calendar = NSCalendar.current
//
//        var anchorComponents = calendar.dateComponents([.day, .month, .year, .weekday], from: NSDate() as Date)
//
//        let offset = (7 + anchorComponents.weekday! - 2) % 7
//
//        anchorComponents.day! -= offset
//        anchorComponents.hour = 2
//
//        guard let anchorDate = Calendar.current.date(from: anchorComponents) else {
//            fatalError("*** unable to create a valid date from the given components ***")
//        }
//
//        let interval = NSDateComponents()
//        interval.minute = 30
//
//        let endDate = Date()
//
//        guard let startDate = calendar.date(byAdding: .day, value: -6, to: endDate) else {
//            fatalError("*** Unable to calculate the start date ***")
//        }
//        guard let quantityType3 = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.walkingStepLength) else {
//            fatalError("*** Unable to create a step count type ***")
//        }
//
//        let query3 = HKStatisticsCollectionQuery(quantityType: quantityType3,
//                                                 quantitySamplePredicate: nil,
//                                                 options: .discreteAverage,
//                                                 anchorDate: anchorDate,
//                                                 intervalComponents: interval as DateComponents)
//
//        query3.initialResultsHandler = {
//            query, results, error in
//
//            guard let statsCollection = results else {
//                fatalError("*** An error occurred while calculating the statistics: \(String(describing: error?.localizedDescription)) ***")
//
//            }
//
//            statsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
//                if let quantity = statistics.averageQuantity() {
//                    let date = statistics.startDate
//                    //for: E.g. for steps it's HKUnit.count()
//                    let value = quantity.doubleValue(for: HKUnit.inch())
//                    //  self.week.mon.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
//                    let today = date.get(.weekday)
//
//                    userData.append(UserData(id: UUID().uuidString, type: .Stride, date: date, data: value))
//
//                }
//
//
//            }
//
//
//            //if (self.values.last ?? 0.0) - 11 > ((defaults.double(forKey: "avg")))  {
//
//
//
//
//
//            //animate2 = true
//
//        }
//        healthStore.execute(query3)
//
//    }
//    func getSpeed() {
//        let calendar = NSCalendar.current
//
//        var anchorComponents = calendar.dateComponents([.day, .month, .year, .weekday], from: NSDate() as Date)
//
//        let offset = (7 + anchorComponents.weekday! - 2) % 7
//
//        anchorComponents.day! -= offset
//        anchorComponents.hour = 2
//
//        guard let anchorDate = Calendar.current.date(from: anchorComponents) else {
//            fatalError("*** unable to create a valid date from the given components ***")
//        }
//
//        let interval = NSDateComponents()
//        interval.minute = 30
//
//        let endDate = Date()
//
//        guard let startDate = calendar.date(byAdding: .day, value: -6, to: endDate) else {
//            fatalError("*** Unable to calculate the start date ***")
//        }
//
//        guard let quantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.walkingSpeed) else {
//            fatalError("*** Unable to create a step count type ***")
//        }
//
//        let query = HKStatisticsCollectionQuery(quantityType: quantityType,
//                                                quantitySamplePredicate: nil,
//                                                options: .discreteAverage,
//                                                anchorDate: anchorDate,
//                                                intervalComponents: interval as DateComponents)
//
//        query.initialResultsHandler = {
//            query, results, error in
//
//            guard let statsCollection = results else {
//                fatalError("*** An error occurred while calculating the statistics: \(String(describing: error?.localizedDescription)) ***")
//
//            }
//
//            statsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
//                if let quantity = statistics.averageQuantity() {
//                    let date = statistics.startDate
//                    //for: E.g. for steps it's HKUnit.count()
//                    let value = quantity.doubleValue(for: HKUnit.mile().unitDivided(by: HKUnit.hour()))
//                    //  self.week.mon.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
//                    let today = date.get(.weekday)
//                    // print("Value")
//                    // print(statsCollection)
//
//                    userData.append(UserData(id: UUID().uuidString, type: .WalkingSpeed, date: date, data: value))
//
//
//                }
//
//
//            }
//
//
//            //if (self.values.last ?? 0.0) - 11 > ((defaults.double(forKey: "avg")))  {
//
//
//        }
//        healthStore.execute(query)
//    }
//
//
//
//    func getDouble() {
//
//        let calendar = NSCalendar.current
//
//        var anchorComponents = calendar.dateComponents([.day, .month, .year, .weekday], from: NSDate() as Date)
//
//        let offset = (7 + anchorComponents.month! - 2) % 7
//
//        anchorComponents.day! -= offset
//        anchorComponents.hour = 2
//
//        guard let anchorDate = Calendar.current.date(from: anchorComponents) else {
//            fatalError("*** unable to create a valid date from the given components ***")
//        }
//
//        let interval = NSDateComponents()
//        interval.minute = 30
//
//        let endDate = Date()
//
//        guard let startDate = calendar.date(byAdding: .day, value: -6, to: endDate) else {
//            fatalError("*** Unable to calculate the start date ***")
//        }
//
//        guard let quantityType2 = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.walkingDoubleSupportPercentage) else {
//            fatalError("*** Unable to create a step count type ***")
//        }
//
//        let query2 = HKStatisticsCollectionQuery(quantityType: quantityType2,
//                                                 quantitySamplePredicate: nil,
//                                                 options: .discreteAverage,
//                                                 anchorDate: anchorDate,
//                                                 intervalComponents: interval as DateComponents)
//
//        query2.initialResultsHandler = {
//            query, results, error in
//
//            guard let statsCollection = results else {
//                fatalError("*** An error occurred while calculating the statistics: \(String(describing: error?.localizedDescription)) ***")
//
//            }
//
//            statsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
//                if let quantity = statistics.averageQuantity() {
//                    let date = statistics.startDate
//                    //for: E.g. for steps it's HKUnit.count()
//                    let value = quantity.doubleValue(for: HKUnit.percent())
//                    //values.append(value*100)
//                    // self.week.mon.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
//                    // print(quantity)
//                    // self.week.mon.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
//
//                    let today = date.get(.weekday)
//
//
//
//
//                    userData.append(UserData(id: UUID().uuidString, type: .Balance, date: date, data: value))
//                }
//
//
//            }
//
//
//            //if (self.values.last ?? 0.0) - 11 > ((defaults.double(forKey: "avg")))  {
//        }
//        healthStore.execute(query2)
//    }
//
//    func getAsym() {
//
//        let calendar = NSCalendar.current
//
//        var anchorComponents = calendar.dateComponents([.day, .month, .year, .weekday], from: NSDate() as Date)
//
//        let offset = (7 + anchorComponents.weekday! - 2) % 7
//
//        anchorComponents.day! -= offset
//        anchorComponents.hour = 2
//
//        guard let anchorDate = Calendar.current.date(from: anchorComponents) else {
//            fatalError("*** unable to create a valid date from the given components ***")
//        }
//
//        let interval = NSDateComponents()
//        interval.minute = 30
//
//        let endDate = Date()
//
//        guard let startDate = calendar.date(byAdding: .day, value: -6, to: endDate) else {
//            fatalError("*** Unable to calculate the start date ***")
//        }
//        guard let quantityType4 = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.walkingAsymmetryPercentage) else {
//            fatalError("*** Unable to create a step count type ***")
//        }
//
//        let query4 = HKStatisticsCollectionQuery(quantityType: quantityType4,
//                                                 quantitySamplePredicate: nil,
//                                                 options: .discreteAverage,
//                                                 anchorDate: anchorDate,
//                                                 intervalComponents: interval as DateComponents)
//
//        query4.initialResultsHandler = {
//            query, results, error in
//
//            guard let statsCollection = results else {
//                fatalError("*** An error occurred while calculating the statistics: \(String(describing: error?.localizedDescription)) ***")
//
//            }
//
//            statsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
//                if let quantity = statistics.averageQuantity() {
//                    let date = statistics.startDate
//                    //for: E.g. for steps it's HKUnit.count()
//                    let value = quantity.doubleValue(for: HKUnit.percent())
//                    //values.append(value*100)
//                    // print(quantity)
//                    // self.week.mon.aysm.append(Asymmetry(id: UUID().uuidString, asym: value, date: date))
//
//                    let components2 = date.get(.weekday, .month, .year)
//                    if let today = components2.weekday {
//
//                        userData.append(UserData(id: UUID().uuidString, type: .Balance, date: date, data: value))
//
//
//                }
//
//
//            }
//
//
//            //if (self.values.last ?? 0.0) - 11 > ((defaults.double(forKey: "avg")))  {
//
//
//
//        }
//        healthStore.execute(query4)
//    }
//
//
//    func getDocumentsDirectory() -> URL {
//        // find all possible documents directories for this user
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//
//        // just send back the first one, which ought to be the only one
//        return paths[0]
//    }
//    func average(numbers: [Double]) -> Double {
//        // print(numbers)
//        return Double(numbers.reduce(0,+))/Double(numbers.count)
//    }
//
//    func createCSV(from recArray:[UserData]) {
//        var input =
//            "ID, Date, Double Support Time, Meds, Step Length, Walking Speed, Score, hasParkinsons"
//
//        progress += 0.1
//
//        let filteredDay = userData.filter { data2 in
//            return data2.date.get(.weekday) == data.date.get(.weekday)
//        }
//
//        let double = filteredDay.filter { data in
//            return  data.type == .Balance
//        }
//
//        let speed = filteredDay.filter { data in
//            return  data.type == .WalkingSpeed
//        }
//        let length = filteredDay.filter { data in
//            return  data.type == .Stride
//        }
//
//        for day in recArray {
//            print(day)
//            input.append("\n")
//            if day.balance.isEmpty {
//                input.append(String("NA"))
//                input.append(",")
//            } else {
//                input.append(String(day.balance.first?.id ?? "NA"))
//                input.append(",")
//            }
//
//            if day.balance.isEmpty {
//                input.append(String("NA"))
//                input.append(",")
//            }  else {
//                input.append("\(day.balance.first?.date ?? Date())")
//                input.append(",")
//            }
//
//
//            if day.balance.isEmpty {
//                input.append(String("NA"))
//                input.append(",")
//            }  else {
//                input.append("\(day.balance.first?.value ?? 0.0)")
//                input.append(",")
//            }
//
//            //            for double in day.aysm {
//            //                input.append(String(double.asym))
//            //                input.append(",")
//            //            }
//            if day.meds.isEmpty {
//                input.append(String("NA"))
//                input.append(",")
//            }  else {
//                input.append("\(day.meds.first?.amountTaken ?? 0.0)")
//                input.append(",")
//            }
//
//            if day.strideLength.isEmpty {
//                input.append(String("NA"))
//                input.append(",")
//            }  else {
//                input.append("\(day.strideLength.first?.length ?? 0.0)")
//                input.append(",")
//            }
//
//            if day.walkingSpeed.isEmpty {
//                input.append(String("NA"))
//                input.append(",")
//            }  else {
//                input.append("\(day.walkingSpeed.first?.speed ?? 0.0)")
//                input.append(",")
//            }
//
//
//
//
//            if day.totalScore == 0.0 {
//                input.append(String(0.0))
//                            input.append(",")
//                        } else {
//                        input.append(String(day.totalScore))
//                        input.append(",")
//
//                        }
//
//            input.append(String(hasParkinsons))
//
//            //print(input)
//        }
//
//
//
//
//        let fileManager = FileManager.default
//        do {
//            let path = try fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
//            let fileURL = getDocumentsDirectory().appendingPathComponent("test.csv")
//            try input.write(to: fileURL, atomically: true, encoding: .utf8)
//            if cta != "Share" {
//            open = true
//            }  else {
//                done = true
//            }
//        } catch {
//            print("error creating file")
//        }
//        if cta == "Share" {
//            let storage = Storage.storage()
//
//
//            let storageRef = storage.reference()
//
//            let riversRef = storageRef.child("data/\(UUID()).csv")
//
//            let encoder = JSONEncoder()
//            let url = getDocumentsDirectory().appendingPathComponent("test.csv")
//            do {
//
//                let input = try String(contentsOf: url)
//
//
//                let jsonData = Data(input.utf8)
//                do {
//                    let decoder = JSONDecoder()
//
//                    do {
//                    }
//
//                    let uploadTask = riversRef.putData(jsonData, metadata: nil) { (metadata, error) in
//                        guard let metadata = metadata else {
//                            // Uh-oh, an error occurred!
//                            return
//                        }
//
//                        //presentationMode.wrappedValue.dismiss()
//
//
//                    }
//
//                } catch {
//                    print(error.localizedDescription)
//                }
//
//            } catch {
//
//            }
//
//            //presentationMode.wrappedValue.dismiss()
//    }
//    }
//
}
    }
}
struct ShareSheet: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
    
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    let callback: Callback? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to do here
    }
}
