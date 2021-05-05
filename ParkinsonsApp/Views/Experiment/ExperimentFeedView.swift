//
//  ExperimentFeedView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/5/21.
//

import SwiftUI

struct ExperimentFeedView: View {
    @Binding var user: User
    @State var experiments = [Experiment(id: UUID(), title: "Running", description: "Will running improve our health?", users: [User](), groupScore: [PredictedScore](), posts: [Post](), week: [Week]()), Experiment(id: UUID(), title: "Running", description: "Will running improve our health?", users: [User](), groupScore: [PredictedScore](), posts: [Post](), week: [Week]()), Experiment(id: UUID(), title: "Running", description: "Will running improve our health?", users: [User](), groupScore: [PredictedScore](), posts: [Post](), week: [Week]()), Experiment(id: UUID(), title: "Running", description: "Will running improve our health?", users: [User](), groupScore: [PredictedScore](), posts: [Post](), week: [Week]())]
    @State var add = false
    var body: some View {
        ScrollView {
        VStack {
            HStack {
                
                Button(action: {
                    add = true
                }) {
                    Image(systemName: "plus")
                        .padding()
                        .font(.title)
                        .foregroundColor(Color("blue"))
                }
                .sheet(isPresented: $add, content: {
                    CreateExperimentView()
                })
                Spacer()
            }
        ForEach(experiments, id: \.self) { experiment in
            ExperimentCard(user: $user, experiment: experiment)
        }
        }
        }
    }
}

