//
//  GridButtonStyle.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/6/21.
//

import SwiftUI

struct GridButtonStyle: ButtonStyle {
    let randomInt = Int.random(in: 0..<3)
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .rotation3DEffect(.degrees(configuration.isPressed ? 0 : 3), axis: (x: 0, y: 1, z: 0))
            .shadow(radius: configuration.isPressed ? 35 : 50)
            .foregroundColor(.primary)
            .animation(.spring())
    }
}
