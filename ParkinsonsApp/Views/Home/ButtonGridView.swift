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
    
    var body: some View {
        
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(buttons.indices, id: \.self) { i in
                ButtonGridButton(gridButton: buttons[i], days: $days)
                    .frame(width: 125, height: 125, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
        }
    }
}

