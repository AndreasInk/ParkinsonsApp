//
//  HabitsCell.swift
//  ParkinsonsApp
//
//  Created by Andreas on 6/4/21.
//

//import SwiftUI
//
//struct HabitsCell: View {
//    @State var progress = 0.0
//    @Binding var experiment: Experiment
//    @State var details = false
//    //@Binding var days: [Day]
//    @Binding var tutorialNum: Int
//    @Binding var isTutorial: Bool
//    
//    var body: some View {
//        ZStack {
//            ProgressView(value: progress)
//                .progressViewStyle(GaugeProgressStyle(experiment: experiment))
//                .onTapGesture {
//                    
//                    details = true
//                }
//                .onLongPressGesture {
//                    if Date().get(.day) != (experiment.habit.last?.date ?? Date()).get(.day) {
//                        if !(experiment.habitToday?.isEmpty ?? true) {
//                        experiment.habitToday!.removeAll()
//                        }
//                    }
//                    experiment.habit.append(Habit(id: UUID(), title: experiment.title, date: Date()))
//                    if !(experiment.habitToday?.isEmpty ?? true) {
//                    experiment.habitToday!.append(Habit(id: UUID(), title: experiment.title, date: Date()))
//                    } else {
//                        experiment.habitToday = [(Habit(id: UUID(), title: experiment.title, date: Date()))]
//                    }
//                }
//                .sheet(isPresented: $details, content: {
//                    DataView(days: $days, gridButton: GridButton(title: "Score and Habits", image: Image("")), tutorialNum: $tutorialNum, isTutorial: $isTutorial, experiment: $experiment)
//                })
//                .onChange(of:  experiment.habit, perform: { value in
//                    
//                    if !(experiment.habitToday?.isEmpty ?? true) {
//                        progress = Double(experiment.habitToday!.count/(experiment.goalPerDay ?? 1))
//                    }
//                    
//                })
//        }
//    }
//}
//
