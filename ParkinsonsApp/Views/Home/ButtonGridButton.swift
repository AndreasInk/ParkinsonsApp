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
            DataView(days: $days, gridButton: gridButton, tutorialNum: $tutorialNum, isTutorial: $isTutorial)
        })
        
    }
}

