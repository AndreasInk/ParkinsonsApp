//
//  ProgressViewStyle.swift
//  ParkinsonsApp
//
//  Created by Andreas on 6/4/21.
//

import SwiftUI

struct GaugeProgressStyle: ProgressViewStyle {
    var strokeColor = Color("teal")
    var strokeWidth = 7.0
    @Binding var experiment: UserData
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0

        return ZStack {
       
            Circle()
                .trim(from: 0, to: CGFloat(fractionCompleted))
                .stroke(strokeColor, style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
                .rotationEffect(.degrees(-90))
                
            
        }
    }
}
