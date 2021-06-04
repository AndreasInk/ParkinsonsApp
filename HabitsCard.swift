//
//  SwiftUIView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 6/4/21.
//

import SwiftUI

struct HabitsCard: View {
    @Binding var experiments: [Experiment]
    @Binding var days: [Day]
    @Binding var tutorialNum: Int
    @Binding var isTutorial: Bool
    @State var add = false
    @State var user = User(id: UUID(), name: "", experiments: [Experiment](), createdExperiments: [Experiment](), posts: [Post](), habit: [Habit]())
    @State var refresh = false
    var columns = [GridItem(.flexible(minimum: 80)), GridItem(.flexible(minimum: 80)), GridItem(.flexible(minimum: 80))]
    var body: some View {
        LazyVGrid(columns: columns) {
        ForEach(experiments.indices, id: \.self) { i in
            HabitsCell(experiment: $experiments[i], days: $days, tutorialNum: $tutorialNum, isTutorial: $isTutorial)
                
        }
        if !experiments.indices.contains(5) {
            Button(action: {
            add = true
            }) {
                ZStack {
            Circle()
                
                .stroke(Color("teal"), style: StrokeStyle(lineWidth: CGFloat(5), lineCap: .round))
               
                    Image(systemName: "plus")
                        .foregroundColor(Color("blue"))
                        .font(.largeTitle)
                        .padding()
                }
            }.sheet(isPresented: $add, content: {
                CreateExperimentView(user: $user, add: $add, experiments: $experiments, refresh: $refresh)
            })
    }
        } .padding(.vertical)
}
}

