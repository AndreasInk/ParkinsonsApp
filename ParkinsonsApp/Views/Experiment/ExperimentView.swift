//
//  ExperimentView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/5/21.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore
struct ExperimentView: View {
    @State var experiment = Experiment(id: UUID(), date: Date(), title: "Running", description: "Will running improve our health?", users: [User](), usersIDs: [String](), groupScore: [PredictedScore](), posts: [Post(id: UUID(), title: "Hello world", text: "Hi there", createdBy: User(id: UUID(), name: "Steve", experiments: [Experiment](), createdExperiments: [Experiment](), posts: [Post]()), comments: [Post(id: UUID(), title: "", text: "Good morning", createdBy: User(id: UUID(), name: "Andreas", experiments: [Experiment](), createdExperiments: [Experiment](), posts: [Post]()), comments: [Post]())])], week: [Week](), imageName: "data2", upvotes: 0)
    @Binding var user: User
    @State var week = Week(id: UUID().uuidString,  sun: Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date(), totalScore: 0.0), mon:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](),  walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date(), totalScore: 0.0), tue:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date(), totalScore: 0.0), wed:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date(), totalScore: 0.0), thur:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date(), totalScore: 0.0), fri:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date(), totalScore: 0.0), sat:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date(), totalScore: 0.0))
    var body: some View {
        VStack {
            ScrollView {
                VStack {
            HStack {
            Text(experiment.title)
                .font(.custom("Poppins-Bold", size: 24, relativeTo: .title))
                Spacer()
            }
            .onAppear() {
                if let thisWeek = experiment.week.last {
                week = thisWeek
                }
            }
            HStack {
            Text(experiment.description)
                .font(.custom("Poppins-Bold", size: 16, relativeTo: .subheadline))
                Spacer()
            }
            .padding(.bottom)
            HStack {
            Text("Group Progress")
                .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                Spacer()
                if experiment.users.map{$0.id}.contains(user.id) {
                Button(action: {
                    
                }) {
                    HStack {
                    
                    Image(systemName: "plus")
                        .padding()
                        .font(.headline)
                        .foregroundColor(Color("blue"))
                        
                        Text("Habit")
                            .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                    }
                }
                }
            }
            .padding(.bottom)
                    
                    WeekChartView(week: $week)
                    if experiment.users.map{$0.id}.contains(user.id) {
                    HStack {
                        Spacer()
                        Button(action: {
                            
                        }) {
                            HStack {
                            Image(systemName: "plus")
                                .padding()
                                .font(.headline)
                                .foregroundColor(Color("blue"))
                                Text("Post")
                                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                            }
                        }
                    }
                    }
//            HalvedCircularBar(progress: CGFloat(experiment.groupScore.last?.prediction ?? 0.0), min: 0, max: 0)
                    ForEach(experiment.posts.indices, id: \.self) { i in
                    PostView(post: experiment.posts[i])
                }
                    .onDisappear() {
                        saveExperiment()
                    }
//                    .onChange(of: experiment, perform: { value in
//                        saveExperiment()
//                    })
                }
            }
            Spacer()
            
            if !experiment.users.map{$0.id}.contains(user.id) {
                Button(action: {
                    
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .foregroundColor(Color("teal"))
                            .frame(height: 75)
                            .padding()
                        Text("Join")
                            .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                            .foregroundColor(.white)
                    }
                }

            }
           
            
        } .padding()
    }
    func saveExperiment() {
        let db = Firestore.firestore()
        do {
            try db.collection("experiments").document(experiment.id.uuidString).setData(from: experiment)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
}

