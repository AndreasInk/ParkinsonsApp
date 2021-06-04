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
    var experiment: Experiment
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0

        return ZStack {
            VStack {
            Image(experiment.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text(experiment.title)
                .font(.custom("Poppins-Bold", size: 16, relativeTo: .title))
                .multilineTextAlignment(.center)
            }  .padding()
            Circle()
                .trim(from: 0, to: CGFloat(fractionCompleted))
                .stroke(strokeColor, style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
                .rotationEffect(.degrees(-90))
                
            
        }
    }
}
