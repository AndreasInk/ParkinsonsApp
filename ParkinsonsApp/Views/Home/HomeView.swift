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
struct HomeView: View {
    @State var welcome = ["Welcome!", "Hello!", "Hello there!"]
    @State var social = false
    @State var settings = false
    @State var openMeds = false
    @State var animateBanner = false
    @State var meds = [Med]()
//    @Binding var week: Week
//    @Binding var days: [Day]
//    @State var experiment = Experiment(id: UUID(), date: Date(), title: "Running", description: "Will running improve our health?", users: [User](), usersIDs: [String](), groupScore: [PredictedScore](), posts: [Post(id: UUID(), title: "Hello world", text: "Hi there", createdBy: User(id: UUID(), name: "Steve", experiments: [Experiment](), createdExperiments: [Experiment](), posts: [Post](), habit: [Habit]()), comments: [Post(id: UUID(), title: "", text: "Good morning", createdBy: User(id: UUID(), name: "Andreas", experiments: [Experiment](), createdExperiments: [Experiment](), posts: [Post](), habit: [Habit]()), comments: [Post]())])], week: [Week](), habit: [Habit](), imageName: "data2", upvotes: 0)
    @Binding var userData: [UserData]
    @State var ready = false
    @Binding var isTutorial: Bool
    @State var tutorialNum = 0
    @Binding var settings2: [Setting]
    @State private var useCount = UserDefaults.standard.integer(forKey: "useCount")
   // @State var experiments = [Experiment]()
    
    var body: some View {
        ZStack {
            
            Color.clear
                .onChange(of: isTutorial, perform: { value in
                    if !isTutorial {
                    load()
                    }
                })
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                    load()
                    }
//                    self.loadPopularExperiments() { experiments in
//                        experiment = experiments.first ?? Experiment(id: UUID(), date: Date(), title: "Running", description: "Will running improve our health?", users: [User](), usersIDs: [String](), groupScore: [PredictedScore](), posts: [Post(id: UUID(), title: "Hello world", text: "Hi there", createdBy: User(id: UUID(), name: "Steve", experiments: [Experiment](), createdExperiments: [Experiment](), posts: [Post](), habit: [Habit]()), comments: [Post(id: UUID(), title: "", text: "Good morning", createdBy: User(id: UUID(), name: "Andreas", experiments: [Experiment](), createdExperiments: [Experiment](), posts: [Post](), habit: [Habit]()), comments: [Post]())])], week: [Week](), habit: [Habit](), imageName: "data2", upvotes: 0)
//
//                    }
                    
                    
//                     let url = self.getDocumentsDirectory().appendingPathComponent("experiments.txt")
//                     do {
//                         
//                         let input = try String(contentsOf: url)
//                         
//                         
//                         let jsonData = Data(input.utf8)
//                         do {
//                             let decoder = JSONDecoder()
//                             
//                             do {
//                                 let note = try decoder.decode([Experiment].self, from: jsonData)
//                                 
//                                 experiments = note
//                                 //                                if i.first!.id == "1" {
//                                 //                                    notes.removeFirst()
//                                 //                                }
//                                 
//                                 
//                             } catch {
//                                 print(error.localizedDescription)
//                             }
//                         }
//                     } catch {
//                         
//                     }
                }
                
                
        ScrollView {
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
//                    Text(welcome.randomElement() ?? "Hello there!")
//                        .bold()
//                        .font(.custom("Poppins-Bold", size: 20, relativeTo: .title))
//                        .foregroundColor(Color("blue"))
//                        .padding(.horizontal)
//                        .opacity(isTutorial ? (tutorialNum == -1 ? 1.0 : 0.1) : 1.0)
                    Spacer()
                        
                    Button(action: {
                        social.toggle()
                    }) {
                        Image(systemName: "person.3")
                            .font(.largeTitle)
                            .padding()
                    }  .opacity(isTutorial ? (tutorialNum == 3 ? 1.0 : 0.1) : 1.0)
                    .sheet(isPresented: $social, content: {
                      //  ExperimentFeedView(user: $user, tutorialNum: $tutorialNum, isTutorial: $isTutorial)
                    })
                    
                    Button(action: {
                        openMeds.toggle()
                    }) {
                        Image(systemName: "pills")
                            .font(.largeTitle)
                            .padding()
                    }  .opacity(isTutorial ? (tutorialNum == 4 ? 1.0 : 0.1) : 1.0)
                    .sheet(isPresented: $openMeds, content: {
                       // MedsView(meds: $meds, week: $week, days: $days, tutorialNum: $tutorialNum, isTutorial: $isTutorial)
                    })
                    
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
                ButtonGridView(userData: $userData, tutorialNum: $tutorialNum, isTutorial: $isTutorial)
                    .onAppear() {
                        if useCount > 3 && useCount < 8 {
                        withAnimation(.easeInOut) {
                        animateBanner = true
                        }
                        }
                    }
               // ExperimentCard(user: $user, experiment: $experiment, tutorialNum: $tutorialNum, isTutorial: $isTutorial)
//                HabitsCard(experiments: $experiments, days: $days, tutorialNum: $tutorialNum, isTutorial: $isTutorial)
//                    .opacity(isTutorial ? (tutorialNum == -1 ? 1.0 : 0.1) : 1.0)
//                    .onChange(of: experiments, perform: { value in
//                        let encoder = JSONEncoder()
//
//                        if let encoded = try? encoder.encode(experiments) {
//                            if let json = String(data: encoded, encoding: .utf8) {
//
//                                do {
//                                    let url = self.getDocumentsDirectory().appendingPathComponent("experiments.txt")
//                                    try json.write(to: url, atomically: false, encoding: String.Encoding.utf8)
//
//                                } catch {
//                                    print("erorr")
//                                }
//                            }
//
//
//                        }
//                    })
                WeekChartView(userData: $userData)
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
                completionHandler(PredictedScore(prediction: prediction.sourceName, predicted_parkinsons: prediction.sourceName > 0.5 ? 1 : 0, date: Date()))
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
        
        do {
            let filtered = userData.filter { data in
                return data.date.get(.weekOfYear) == Date().get(.weekOfYear)
            }
            for data in filtered {
                let filteredDay = userData.filter { data2 in
                    return data2.date.get(.weekday) == data.date.get(.weekday)
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
               // week.mon.totalScore = score.prediction
                    userData.append(UserData(id: UUID().uuidString, type: .Score, date: double.last?.date ?? Date(), data: score.prediction))
//                if week.mon.balance.last?.date.get(.day) ?? 0 == Date().get(.day) {
//                    // progressValue = score.prediction
//                }
            }
            
        }
        }
       
           
        
        
        if isTutorial {
            ready = true
            print(tutorialNum)
        } else {
           
            
        }
     
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            ready = true
        }
    }
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}


