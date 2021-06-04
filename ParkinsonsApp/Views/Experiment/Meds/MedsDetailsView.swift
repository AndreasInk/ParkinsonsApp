//
//  MedsDetailsView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/7/21.
//

import SwiftUI

struct MedsDetailsView: View {
    @Binding var med: Med
    @Binding var week: Week
    @State var edit = false
    @State var moreData = false
    @State var i = 0
    @Binding var days: [Day]
    
    @State var isTutorial = false
    @State var tutorialNum = 0
    
    @State var created = false
    
    @State var experiment = Experiment(id: UUID(), date: Date(), title: "Running", description: "Will running improve our health?", users: [User](), usersIDs: [String](), groupScore: [PredictedScore](), posts: [Post](), week: [Week](), habit: [Habit](), imageName: "data2", upvotes: 0)
    var body: some View {
        ScrollView {
        VStack {
            HStack {
                DismissSheetBtn()
                Spacer()
                Button(action: {
                    edit.toggle()
                }) {
                    Text("Edit")
                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                }
            }
            .sheet(isPresented: $edit, content: {
                EditMedsView(med: $med, add: $edit)
            })
           
                HStack {
            Image(systemName: "pills")
                .font(.largeTitle)
                
                    Button(action: {
                        med.amountTaken += med.amountNeeded
                        created = true
                    }) {
                        Image(systemName: "plus")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()
                            .padding()
                            .background(Circle().foregroundColor(Color("teal")).padding())
                    }
                } .padding(.bottom)
            Text(med.name)
                .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
            Text(med.notes)
                .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
                .padding(.bottom)
                
                
            
            Spacer()
            HStack {
                Spacer()
//            Button(action: {
//                
//                moreData = true
//            }) {
//                HStack {
//                    Image(systemName: "chart.bar")
//                        .padding()
//                        .font(.headline)
//                        .foregroundColor(Color("blue"))
//                    Text("More Data")
//                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
//                }
//            }
        } .sheet(isPresented: $moreData, content: {
            DataView(days: $days, gridButton: GridButton(title: "Score and Meds", image: Image("")), tutorialNum: $tutorialNum, isTutorial: $isTutorial, experiment: $experiment)
        })
            
            .sheet(isPresented: $created, content: {
                ZStack {
                VStack {
                    DismissSheetBtn()
                    Spacer()
                    Text("Added \(med.amountNeeded.removeZerosFromEnd()) \(med.unit) of \(med.name)")
                    .font(.custom("Poppins-Bold", size: 24, relativeTo: .headline))
                    
                    Spacer()
                }
                    ForEach(0 ..< 20) { number in
                                        ConfettiView()
                                        }
                }
            })
            MedsWeekChartView(week: $week, med: $med)
            WeekChartView(week: $week)
//            Stepper(value: $med.amountTaken, in: 0...1000) {
//                Text("Amount Taken Today: " + String(med.amountTaken) + " " + med.unit)
//                    .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
//
//            }
          
        } .padding()
       
        }
    }
}

