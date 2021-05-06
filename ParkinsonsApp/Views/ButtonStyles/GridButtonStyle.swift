//
//  GridButtonStyle.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/6/21.
//

import SwiftUI

struct GridButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .rotation3DEffect(.degrees(configuration.isPressed ? 0 : 3), axis: (x: 0, y: 1, z: 0))
            .shadow(color: Color("blue").opacity(0.4), radius: configuration.isPressed ? 30 : 40)
            .animation(.spring())
    }
}
