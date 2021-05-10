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
    @Binding var week: Week
    @Binding var days: [Day]
    @State var experiment = Experiment(id: UUID(), date: Date(), title: "Running", description: "Will running improve our health?", users: [User](), usersIDs: [String](), groupScore: [PredictedScore](), posts: [Post(id: UUID(), title: "Hello world", text: "Hi there", createdBy: User(id: UUID(), name: "Steve", experiments: [Experiment](), createdExperiments: [Experiment](), posts: [Post](), habit: [Habit]()), comments: [Post(id: UUID(), title: "", text: "Good morning", createdBy: User(id: UUID(), name: "Andreas", experiments: [Experiment](), createdExperiments: [Experiment](), posts: [Post](), habit: [Habit]()), comments: [Post]())])], week: [Week](), habit: [Habit](), imageName: "data2", upvotes: 0)
    @Binding var user: User
    @State var ready = false
    @Binding var isTutorial: Bool
    @State var tutorialNum = 0
    @Binding var settings2: [Setting]
    @State private var useCount = UserDefaults.standard.integer(forKey: "useCount")
    var body: some View {
        ZStack {
            
            Color.clear
                .onChange(of: isTutorial, perform: { value in
                    if !isTutorial {
                    load()
                    }
                })
                .onAppear() {
                    load()
                    self.loadPopularExperiments() { experiments in
                        experiment = experiments.first ?? Experiment(id: UUID(), date: Date(), title: "Running", description: "Will running improve our health?", users: [User](), usersIDs: [String](), groupScore: [PredictedScore](), posts: [Post(id: UUID(), title: "Hello world", text: "Hi there", createdBy: User(id: UUID(), name: "Steve", experiments: [Experiment](), createdExperiments: [Experiment](), posts: [Post](), habit: [Habit]()), comments: [Post(id: UUID(), title: "", text: "Good morning", createdBy: User(id: UUID(), name: "Andreas", experiments: [Experiment](), createdExperiments: [Experiment](), posts: [Post](), habit: [Habit]()), comments: [Post]())])], week: [Week](), habit: [Habit](), imageName: "data2", upvotes: 0)
                        
                    }
                }
                
                
        ScrollView {
            if ready {
            VStack {
                if isTutorial {
                    VStack {
                        Spacer()
                        Text( tutorialNum == 0 ? "Tap this button to access your score." :  tutorialNum == 1 ? "Tap this button to access your balance data." : tutorialNum == 2 ? "Tap this button to access your stride data." : tutorialNum == 3 ? "Tap this button to find habit experiments and connect with others." : tutorialNum == 4 ? "Tap this button to keep track of your medications." : tutorialNum == 5 ? "Tap this button to change your settings." : tutorialNum == 6 ? "This is your score that you can slide through to see each day of the week, a 0 may indicate that you are healthy while a 1 may indicate you are showing more intense symptoms." : "")
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
                        ExperimentFeedView(user: $user, tutorialNum: $tutorialNum, isTutorial: $isTutorial)
                    })
                    
                    Button(action: {
                        openMeds.toggle()
                    }) {
                        Image(systemName: "pills")
                            .font(.largeTitle)
                            .padding()
                    }  .opacity(isTutorial ? (tutorialNum == 4 ? 1.0 : 0.1) : 1.0)
                    .sheet(isPresented: $openMeds, content: {
                        MedsView(meds: $meds, week: $week, days: $days, tutorialNum: $tutorialNum, isTutorial: $isTutorial)
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
                ButtonGridView(days: $days, tutorialNum: $tutorialNum, isTutorial: $isTutorial)
                    .onAppear() {
                        if useCount > 3 && useCount < 8 {
                        withAnimation(.easeInOut) {
                        animateBanner = true
                        }
                        }
                    }
                ExperimentCard(user: $user, experiment: $experiment, tutorialNum: $tutorialNum, isTutorial: $isTutorial)
                    .opacity(isTutorial ? (tutorialNum == -1 ? 1.0 : 0.1) : 1.0)
                   
                WeekChartView(week: $week)
                    .opacity(isTutorial ? (tutorialNum == 6 ? 1.0 : 0.1) : 1.0)
                   
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
            let double = week.mon.balance.map({ $0.value })
            
            let speed = week.mon.walkingSpeed.map({ $0.speed })
            let length = week.mon.strideLength.map({ $0.length })
            
            
            
            getLocalScore(double: average(numbers: double), speed: average(numbers: speed), length: average(numbers: length)) { (score) in
                week.mon.totalScore = score.prediction
                if week.mon.balance.last?.date.get(.day) ?? 0 == Date().get(.day) {
                    // progressValue = score.prediction
                }
            }
            
        }
        do {
            let double = week.tue.balance.map({ $0.value })
            let speed = week.tue.walkingSpeed.map({ $0.speed })
            let length = week.tue.strideLength.map({ $0.length })
            
            
            
            getLocalScore(double: average(numbers: double), speed: average(numbers: speed), length: average(numbers: length)) { (score) in
                week.tue.totalScore = score.prediction
                if week.tue.balance.last?.date.get(.day) ?? 0 == Date().get(.day) {
                    // progressValue = score.prediction
                }
            }
            
            
        }
        do {
            let double = week.wed.balance.map({ $0.value })
            let speed = week.wed.walkingSpeed.map({ $0.speed })
            let length = week.wed.strideLength.map({ $0.length })
            
            
            
            
            getLocalScore(double: average(numbers: double), speed: average(numbers: speed), length: average(numbers: length)) { (score) in
                week.wed.totalScore = score.prediction
                if week.wed.balance.last?.date.get(.day) ?? 0 == Date().get(.day) {
                    //progressValue = score.prediction
                }
            }
            
            
            
        }
        do {
            let double = week.thur.balance.map({ $0.value })
            let speed = week.thur.walkingSpeed.map({ $0.speed })
            let length = week.thur.strideLength.map({ $0.length })
            
            
            
            getLocalScore(double: average(numbers: double), speed: average(numbers: speed), length: average(numbers: length)) { (score) in
                week.thur.totalScore = score.prediction
                if week.thur.balance.last?.date.get(.day) ?? 0 == Date().get(.day) {
                    // progressValue = score.prediction
                }
            }
            
        }
        do {
            let double = week.fri.balance.map({ $0.value })
            let speed = week.fri.walkingSpeed.map({ $0.speed })
            let length = week.fri.strideLength.map({ $0.length })
            
            
            
            getLocalScore(double: average(numbers: double), speed: average(numbers: speed), length: average(numbers: length)) { (score) in
                week.fri.totalScore = score.prediction
                if week.fri.balance.last?.date.get(.day) ?? 0 == Date().get(.day) {
                    // progressValue = score.prediction
                }
            }
            
        }
        do {
            let double = week.sat.balance.map({ $0.value })
            let speed = week.sat.walkingSpeed.map({ $0.speed })
            let length = week.sat.strideLength.map({ $0.length })
            
            
            
            getLocalScore(double: average(numbers: double), speed: average(numbers: speed), length: average(numbers: length)) { (score) in
                week.sat.totalScore = score.prediction
                if week.sat.balance.last?.date.get(.day) ?? 0 == Date().get(.day) {
                    //  progressValue = score.prediction
                }
            }
            
            
        }
        do {
            let double = week.sun.balance.map({ $0.value })
            let speed = week.sun.walkingSpeed.map({ $0.speed })
            let length = week.sun.strideLength.map({ $0.length })
            
            
            
            
            getLocalScore(double: average(numbers: double), speed: average(numbers: speed), length: average(numbers: length)) { (score) in
                week.sun.totalScore = score.prediction
                if week.sun.balance.last?.date.get(.day) ?? 0 == Date().get(.day) {
                    // progressValue = score.prediction
                }
            }
            
           
        }
        
        if isTutorial {
            ready = true
            print(tutorialNum)
        } else {
           
            
        }
        days.append(week.mon)
        days.append(week.tue)
        days.append(week.wed)
        days.append(week.thur)
        days.append(week.fri)
        days.append(week.sat)
        days.append(week.sun)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            ready = true
        }
    }
}


