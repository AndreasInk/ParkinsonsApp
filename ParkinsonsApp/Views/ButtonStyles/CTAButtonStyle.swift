//
//  CTAButtonStyle.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/6/21.
//

import SwiftUI

struct CTAButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2))
    }
}
