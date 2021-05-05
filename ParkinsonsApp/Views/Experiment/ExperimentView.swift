//
//  ExperimentView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/5/21.
//

import SwiftUI

struct ExperimentView: View {
    @State var experiment: Experiment
    @Binding var user: User
    @State var week = Week(id: UUID().uuidString,  sun: Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date()), mon:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](),  walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date()), tue:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date()), wed:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date()), thur:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date()), fri:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date()), sat:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date()))
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
            }
            .padding(.bottom)
                    
                    WeekChartView(week: $week)
//            HalvedCircularBar(progress: CGFloat(experiment.groupScore.last?.prediction ?? 0.0), min: 0, max: 0)
                ForEach(experiment.posts, id: \.self) { post in
                    PostView(post: post)
                }
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
}

