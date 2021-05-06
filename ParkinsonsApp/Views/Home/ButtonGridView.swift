//
//  ButtonGridView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI

struct ButtonGridView: View {
    let columns = [
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80))
    ]
    @Binding var days: [Day]
    @State var buttons = [GridButton(title: "Score", image: Image(systemName: "heart")), GridButton(title: "Balance", image: Image(systemName: "scalemass")),GridButton(title: "Stride", image: Image(systemName: "ruler"))]
    //GridButton(title: "Speed", image: Image(systemName: "figure.walk")), GridButton(title: "Steps", image: Image(systemName: "arrow.forward")), GridButton(title: "Friends", image: Image(systemName: "person.3"))
    @Binding var tutorialNum: Int
    @Binding var isTutorial: Bool
    var body: some View {
        
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(buttons.indices, id: \.self) { i in
                ButtonGridButton(gridButton: buttons[i], days: $days, tutorialNum: $tutorialNum, isTutorial: $isTutorial)
                    .frame(width: 125, height: 125, alignment: .center)
                    
                    .opacity(isTutorial ? (tutorialNum == i ? 1.0 : 0.1) : 1.0)
            }
            
        }
    }
}

