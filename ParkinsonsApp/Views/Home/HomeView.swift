//
//  HomeView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI
import CoreML
import FirebaseFirestore
import FirebaseFirestoreSwift
import HealthKit
struct HomeView: View {
    @State var welcome = ["Welcome!", "Hello!", "Hello there!"]
    @State var social = false
    @State var settings = false
    @State var openMeds = false
    @State var animateBanner = false
    @State var meds = [Med]()
    @State var dataTypes = UserDefaults.standard.stringArray(forKey: "types") ?? []
    @State var notFirstRun = UserDefaults.standard.bool(forKey: "notFirstRun")

    @Binding var userData: [UserData]
    
    @State var habits = [Habit]()
    @State var data = [UserData]()
    
    @State var ready = false
    @Binding var isTutorial: Bool
    @State var tutorialNum = 0
    @Binding var settings2: [Setting]
    @State private var useCount = UserDefaults.standard.integer(forKey: "useCount")
    @Binding var habitsUserData: [UserData]
    var body: some View {
        ZStack {
            
            Color.clear
                .onChange(of: isTutorial, perform: { value in
                    if !isTutorial {
                    load()
                    }
                })
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    load()
                       
                    }
                    
                }
                .onChange(of: habits) { value in
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(habits) {
                        if let json = String(data: encoded, encoding: .utf8) {
                          
                            do {
                                let url = self.getDocumentsDirectory().appendingPathComponent("habits.txt")
                                try json.write(to: url, atomically: false, encoding: String.Encoding.utf8)
                                
                            } catch {
                                print("erorr")
                            }
                        }
                        
                        
                    }
                    for data in habits.map{$0.data} {
                    userData.append(contentsOf: data)
                    }
                }
                .onAppear() {
                    let url3 = self.getDocumentsDirectory().appendingPathComponent("habits.txt")
                    do {
                        
                        let input = try String(contentsOf: url3)
                        
                        
                        let jsonData = Data(input.utf8)
                        do {
                            let decoder = JSONDecoder()
                            
                            do {
                                let note = try decoder.decode([Habit].self, from: jsonData)
                                
                                habits = note
                                print(note)
                               
                                
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                }  catch {
                    print(error.localizedDescription)
                }
            }
                .onAppear() {
                    let types: [HKQuantityTypeIdentifier] = [.walkingStepLength, .walkingSpeed, .walkingAsymmetryPercentage, .walkingDoubleSupportPercentage]
                    if !notFirstRun {
                    dataTypes.append(contentsOf: types.map{$0.rawValue})
                       
                        let presetHabitsTitles = ["Happiness Score", "Medications", "Doctor Appointments", "Push-ups"]
                        let presetHabits = presetHabitsTitles.map{Habit(id: UUID().uuidString, data: [UserData](), title: $0)}
                        habits.append(contentsOf: presetHabits)
                        UserDefaults.standard.set(true, forKey:  "notFirstRun")
                        notFirstRun = true
                        
                    }
                    load()

                }
                
                
       
            if ready {
            VStack {
                if isTutorial {
                    VStack {
                        Spacer()
                        Text( tutorialNum == 0 ? "Tap this button to access your score." :  tutorialNum == 1 ? "Tap this button to access your balance data." : tutorialNum == 2 ? "Tap this button to access your stride data." : tutorialNum == 3 ? "Tap this button to find habit experiments and connect with others." : tutorialNum == 4 ? "Tap this button to keep track of your medications." : tutorialNum == 5 ? "Tap this button to change your settings." : tutorialNum == 6 ? "Below is your score that you can slide through to see each day of the week, a 0 may indicate that you are healthy while a 1 may indicate you are showing more intense symptoms." : "")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                        
                        
                    
                }
                    if tutorialNum == 6 {
                        Button(action: {
                       isTutorial = false
                            UserDefaults.standard.setValue(1, forKey: "useCount")
                            load()
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .foregroundColor(Color(.lightGray))
                                    .frame(height: 75)
                                    .padding()
                                Text("Done!")
                                    .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                                    .foregroundColor(.white)
                            }
                        } .buttonStyle(CTAButtonStyle())
                    }
                }
                HStack {
                    Spacer()
                    Button(action: {
                        openMeds.toggle()
                    }) {
                        Image(systemName: "chart.bar")
                            .font(.largeTitle)
                            .padding()
                    }  .opacity(isTutorial ? (tutorialNum == 4 ? 1.0 : 0.1) : 1.0)
                    .sheet(isPresented: $openMeds, content: {
                        CollectListView(habits: $habits, dataTypes: $dataTypes, userData: $userData)
                    })
//
                    Button(action: {
                        settings.toggle()
                    }) {
                        Image(systemName: "gear")
                            .font(.largeTitle)
                            .padding()
                    }  .opacity(isTutorial ? (tutorialNum == 5 ? 1.0 : 0.1) : 1.0)
                    .sheet(isPresented: $settings, content: {
                        SettingsView(settings: $settings2, tutorialNum: $tutorialNum, isTutorial: $isTutorial)
                    })
                    
                }
                
               
                //CardView()
                if animateBanner {
                ShareDataBanner()
                    .transition(.move(edge: .top))
                }
                ButtonGridView(userData: $userData, dataTypes: $dataTypes, tutorialNum: $tutorialNum, isTutorial: $isTutorial)
                    .onAppear() {
                        if useCount > 3 && useCount < 8 {
                        withAnimation(.easeInOut) {
                        animateBanner = true
                        }
                        }
                    }
                HappinessScoreInputView(habit: $habits[habits.firstIndex{$0.title == "Happiness Score"} ?? 0])
                if ready {
                    
                    WeekChartView(userData: $userData, dataTypes: $dataTypes)
                    .opacity(isTutorial ? (tutorialNum == 6 ? 1.0 : 0.1) : 1.0)
                    .padding(.bottom)
            }
            }
        
        }
     
        } 
        
    }
    func getLocalScore(double: Double, speed: Double, length: Double, completionHandler: @escaping (PredictedScore) -> Void) {
        
        if double.isNormal {
            do {
                let model = try reg_model(configuration: MLModelConfiguration())
                let prediction =  try model.prediction(double_: double, speed: speed, length: length)
                completionHandler(PredictedScore(prediction: prediction.sourceName, predicted_parkinsons: (prediction.sourceName) > 0.5 ? 1 : 0, date: Date()))
            } catch {
                
            }
        } else {
            completionHandler(PredictedScore(prediction: 21.0, predicted_parkinsons: 21, date: Date()))
        }
    }
    
    func average(numbers: [Double]) -> Double {
        // print(numbers)
        return Double(numbers.reduce(0,+))/Double(numbers.count)
    }
    func loadPopularExperiments(performAction: @escaping ([Experiment]) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("experiments")
        var userList = [Experiment]()
        let query = docRef.order(by: "upvotes")
        query.getDocuments { (documents, error) in
            if !(documents?.isEmpty ?? true) {
                for document in documents!.documents {
                    let result = Result {
                        try document.data(as: Experiment.self)
                    }
                    
                    switch result {
                    case .success(let user):
                        if let user = user {
                            userList.append(user)
                            
                        } else {
                            
                            print("Document does not exist")
                        }
                    case .failure(let error):
                        print("Error decoding user: \(error)")
                    }
                    
                    
                }
            }
            performAction(userList)
        }
    }
    func load() {
        ready = false
        
        
            let filtered = userData.filter { data in
                return data.date.get(.weekOfYear) == Date().get(.weekOfYear)
            }
        for day in 0...7 {
            print(day)
                let filteredDay = filtered.filter { data2 in
                    return data2.date.get(.weekday) == day
                }
                
                let double = filteredDay.filter { data in
                    return  data.type == .Balance
                }
            
                let speed = filteredDay.filter { data in
                    return  data.type == .WalkingSpeed
                }
                let length = filteredDay.filter { data in
                    return  data.type == .Stride
                }
            
            
            
               getLocalScore(double: average(numbers: double.map{$0.data}), speed: average(numbers: speed.map{$0.data}), length: average(numbers: length.map{$0.data})) { (score) in
         
                   userData.append(UserData(id: UUID().uuidString, type: .Score, title: "", text: "", date: length.last?.date ?? Date(), data: score.prediction))

            
                }
        }
        
       
           
        
        
       
     
        
        let filteredhabits = userData.filter { data in
            return data.type == .Habit
        }
        habitsUserData = filteredhabits
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            ready = true
            for data in habits.map{$0.data} {
            userData.append(contentsOf: data)
            }
        }
    }
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}


