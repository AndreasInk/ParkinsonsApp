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
    @State var week = Week(id: UUID().uuidString,  sun: Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), mon:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), tue:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), wed:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), thur:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), fri:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), sat:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()))
    @State var chartData =  ChartData(values: [("", 0.0)])
    @State var showAddHabit = true
    @State var refresh = false
    @State var addPost = false
    @State var moreData = false
    
    @State var days = [Day]()
    
    @Binding var tutorialNum: Int
    @Binding var isTutorial: Bool
    
   
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    
                    DismissSheetBtn()
                    VStack {
                    HStack {
                        Text(experiment.title)
                            .font(.custom("Poppins-Bold", size: 24, relativeTo: .title))
                        Spacer()
                    }
                    .onAppear() {
                        if let thisWeek = experiment.week.last {
                            week = thisWeek
                            days.append(week.mon)
                            days.append(week.tue)
                            days.append(week.wed)
                            days.append(week.thur)
                            days.append(week.fri)
                            days.append(week.sat)
                            days.append(week.sun)
                            print(experiment.groupScore)
                          
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
                        //if showAddHabit {
                            if experiment.users.map{$0.id}.contains(user.id) {
                                Button(action: {
                                    experiment.habit.append(Habit(id: UUID(), title: "Run", date: Date()))
                                   
                                    for habit in experiment.habit {
                                        let today = habit.date.get(.weekday)
                                        
                                        //print(value)
                                        
                                        //   if "\(today)" + "\(month)" + "\(year)" == "\(today)" + "\(month2)" + "\(year2)" {
                                        if experiment.week.indices.contains(experiment.week.count - 1) {
                                            if today == 2 {
                                                experiment.week[experiment.week.count - 1].mon.habit.append(Habit(id: UUID(), title: ("Monday"), date: Date()))
                                            } else if today == 3 {
                                                
                                                experiment.week[experiment.week.count - 1].tue.habit.append(Habit(id: UUID(), title: ("Tuesday"), date: Date()))
                                                
                                            } else if today == 4 {
                                                experiment.week[experiment.week.count - 1].wed.habit.append(Habit(id: UUID(), title: ("Wednesday"), date: Date()))
                                            } else if today == 5 {
                                                experiment.week[experiment.week.count - 1].thur.habit.append(Habit(id: UUID(), title: ("Thursday"), date: Date()))
                                            }  else if today == 6 {
                                                experiment.week[experiment.week.count - 1].fri.habit.append(Habit(id: UUID(), title: ("Friday"), date: Date()))
                                            }  else if today == 7 {
                                                experiment.week[experiment.week.count - 1].sat.habit.append(Habit(id: UUID(), title: ("Saturday"), date: Date()))
                                            } else if today == 1 {
                                                experiment.week[experiment.week.count - 1].sun.habit.append(Habit(id: UUID(), title: ("Sunday"), date: Date()))
                                                
                                            }
                                        } else {
                                            experiment.week.append(Week(id: UUID().uuidString,  sun: Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), mon:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](),  walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), tue:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), wed:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), thur:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), fri:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), sat:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]())))
                                            
                                            let today = habit.date.get(.weekday)
                                            
                                            //print(value)
                                            
                                            //   if "\(today)" + "\(month)" + "\(year)" == "\(today)" + "\(month2)" + "\(year2)" {
                                            
                                            if today == 1 {
                                                experiment.week[experiment.week.count - 1].mon.habit.append(Habit(id: UUID(), title: ("Monday"), date: Date()))
                                            } else if today == 2 {
                                                
                                                experiment.week[experiment.week.count - 1].tue.habit.append(Habit(id: UUID(), title: ("Tuesday"), date: Date()))
                                                
                                            } else if today == 3 {
                                                experiment.week[experiment.week.count - 1].wed.habit.append(Habit(id: UUID(), title: ("Wednesday"), date: Date()))
                                            } else if today == 4 {
                                                experiment.week[experiment.week.count - 1].thur.habit.append(Habit(id: UUID(), title: ("Thursday"), date: Date()))
                                            }  else if today == 5 {
                                                experiment.week[experiment.week.count - 1].fri.habit.append(Habit(id: UUID(), title: ("Friday"), date: Date()))
                                            }  else if today == 6 {
                                                experiment.week[experiment.week.count - 1].sat.habit.append(Habit(id: UUID(), title: ("Saturday"), date: Date()))
                                            } else if today == 0 {
                                                experiment.week[experiment.week.count - 1].sun.habit.append(Habit(id: UUID(), title: ("Sunday"), date: Date()))
                                                
                                            }
                                        }
                                        
                                    }
                                    saveExperiment()
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
                       // }
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Text("Score Progress")
                            .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                        Spacer()
                        
                        Button(action: {
                            
                            moreData = true
                        }) {
                            HStack {
                                Image(systemName: "chart.bar")
                                    .padding()
                                    .font(.headline)
                                    .foregroundColor(Color("blue"))
                                Text("More Data")
                                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                            }
                        }
                    } .sheet(isPresented: $moreData, content: {
                        DataView(days: $days, gridButton: GridButton(title: "Score and Habits", image: Image("")), tutorialNum: $tutorialNum, isTutorial: $isTutorial, experiment: $experiment)
                    }).onAppear() {
                        
                    }
                    WeekChartView(week: $week)
                    HStack {
                        Text("Habit Progress")
                            .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                        Spacer()
                    }
                    HabitWeekChartView(week: $week)
                        .onAppear() {
                            days.append(week.mon)
                            days.append(week.tue)
                            days.append(week.wed)
                            days.append(week.thur)
                            days.append(week.fri)
                            days.append(week.sat)
                            days.append(week.sun)
                        }
                    if experiment.users.map{$0.id}.contains(user.id) {
                        HStack {
                            Spacer()
                            Button(action: {
                                
                                addPost = true
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
                        } .sheet(isPresented: $addPost, content: {
                            AddPostView(experiment: $experiment, user: $user, addPost: $addPost)
                        })
                    }
                    //            HalvedCircularBar(progress: CGFloat(experiment.groupScore.last?.prediction ?? 0.0), min: 0, max: 0)
                    ForEach(experiment.posts.indices, id: \.self) { i in
                        PostView(experiment: $experiment, i: i, user: $user)
                    }
                    
                    //                    .onChange(of: experiment, perform: { value in
                    //                        saveExperiment()
                    //                    })
                }
            } .padding()
            Spacer()
                .onDisappear() {
                    saveExperiment()
                }
            if !experiment.users.map{$0.id}.contains(user.id) {
                Button(action: {
                    experiment.users.append(user)
                    experiment.usersIDs.append(user.id.uuidString)
                    user.experiments.append(experiment)
                    saveExperiment()
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
            }
            
        }
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

