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
    @Binding var experiment: Experiment
    @Binding var user: User
    @State var week = Week(id: UUID().uuidString,  sun: Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date(), totalScore: 0.0), mon:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](),  walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date(), totalScore: 0.0), tue:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date(), totalScore: 0.0), wed:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date(), totalScore: 0.0), thur:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date(), totalScore: 0.0), fri:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date(), totalScore: 0.0), sat:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date(), totalScore: 0.0))
    @State var chartData =  ChartData(values: [("", 0.0)])
    @State var showAddHabit = true
    @State var refresh = false
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
                if let habit = experiment.habit {
                for habit in habit {
                    chartData.points.append((String(habit.title), 1))
                }
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
                if showAddHabit {
                if experiment.users.map{$0.id}.contains(user.id) {
                Button(action: {
                    experiment.habit?.append(Habit(id: UUID(), title: (experiment.habit?.last?.title ?? ""), date: Date()))
                    showAddHabit = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 180.0) {
                        showAddHabit = true
                    }
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
            }
            .padding(.bottom)
                    HStack {
                    Text("Score Progress")
                        .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                        Spacer()
                    }
                    WeekChartView(week: $week)
                    HStack {
                    Text("Habit Progress")
                        .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                        Spacer()
                    }
                    DayChartView(title: "", chartData: $chartData, refresh: $refresh)
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
                        PostView(experiment: $experiment, i: i)
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

