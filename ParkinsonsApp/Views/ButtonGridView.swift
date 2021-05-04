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
    @State var buttons = [GridButton(title: "Score", image: Image(systemName: "heart")), GridButton(title: "Balance", image: Image(systemName: "heart")),GridButton(title: "Stride", image: Image(systemName: "heart")), GridButton(title: "Speed", image: Image(systemName: "heart")), GridButton(title: "Steps", image: Image(systemName: "heart")), GridButton(title: "Friends", image: Image(systemName: "heart"))]
    var body: some View {
        GeometryReader { geo in
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(buttons.indices, id: \.self) { i in
                ButtonGridButton(gridButton: buttons[i])
                    .frame(height: geo.size.width/3)
            }
        }
        }
    }
}

struct ButtonGridView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonGridView()
    }
}
