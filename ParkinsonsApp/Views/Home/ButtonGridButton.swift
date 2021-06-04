//
//  ButtonGridButton.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI

struct ButtonGridButton: View {
    
    @State var gridButton: GridButton
    @State var open = false
    
    @Binding var days: [Day]
    
    @Binding var tutorialNum: Int
    @Binding var isTutorial: Bool
    
    @State var experiment = Experiment(id: UUID(), date: Date(), title: "Running", description: "Will running improve our health?", users: [User](), usersIDs: [String](), groupScore: [PredictedScore](), posts: [Post](), week: [Week](), habit: [Habit](), imageName: "data2", upvotes: 0)
    var body: some View {
        
        Button(action: {
            open.toggle()
            if isTutorial {
                tutorialNum += 1
            }
        }) {
            VStack {
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(Color("blue"))
                    
                    gridButton.image
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                Text(gridButton.title)
                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                
            }.padding(.horizontal)
            
        } .buttonStyle(GridButtonStyle())
        
        .sheet(isPresented: $open, content: {
            DataView(days: $days, gridButton: gridButton, tutorialNum: $tutorialNum, isTutorial: $isTutorial, experiment:$experiment)
        })
        
    }
}

