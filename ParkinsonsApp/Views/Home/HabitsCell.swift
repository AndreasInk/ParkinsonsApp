//
//  HabitsCell.swift
//  ParkinsonsApp
//
//  Created by Andreas on 6/4/21.
//

import SwiftUI

struct HabitsCell: View {
    @State var progress = 0.0
    @Binding var userData: UserData
    @State var details = false
    //@Binding var days: [Day]
    @Binding var tutorialNum: Int
    @Binding var isTutorial: Bool
    
    var body: some View {
        ZStack {
            ProgressView(value: progress)
                .progressViewStyle(GaugeProgressStyle(experiment: userData))
                .onTapGesture {
                    
                   // details = true
                }
                .onLongPressGesture {
                    if Date().get(.day) == userData.date.get(.day) {
                        
                        userData.data += 1
                        } else {
                            
                            userData.data = 0.0
                        }
                        
                    }
                    
                }
                .sheet(isPresented: $details, content: {
                   // DataView(days: $days, gridButton: GridButton(title: "Score and Habits", image: Image("")), tutorialNum: $tutorialNum, isTutorial: $isTutorial, userData: $userData)
                })
                .onChange(of:  userData, perform: { value in
                    
                   
                    progress = Double(userData.data/(userData.goal ?? 1))
                    
                    
                })
        }
    }

