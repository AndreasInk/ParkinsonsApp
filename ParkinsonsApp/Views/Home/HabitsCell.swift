//
//  HabitsCell.swift
//  ParkinsonsApp
//
//  Created by Andreas on 6/4/21.
//

import SwiftUI

struct HabitsCell: View {
    @State var progress = 0.0
    @Binding var habitsUserData: UserData
    @Binding var userData: [UserData]
    @State var filteredForDate: [UserData] = []
    @State var details = false
    @State var additionalInput = false
    //@Binding var days: [Day]
   
    @Binding var tutorialNum: Int
    @Binding var isTutorial: Bool
    
    @State var value = 0.0
    
    var body: some View {
        ZStack {
            
            ProgressView(value: progress)
                .progressViewStyle(GaugeProgressStyle(experiment: $habitsUserData))
               
               
            Text(habitsUserData.title)
            .font(.custom("Poppins-Bold", size: 16, relativeTo: .title))
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
            .padding()
        }
            .onTapGesture {
               
                details = true
            }
            .onLongPressGesture {
                let filtered = userData.filter { data in
                    return data.id == habitsUserData.id
                }
                 filteredForDate = filtered.filter { data in
                    return data.date.get(.weekOfYear) == Date().get(.weekOfYear) && data.date.get(.weekday) == Date().get(.weekday)
                }
                    
                    if UserDefaults.standard.bool(forKey: filteredForDate.last?.id ?? "") {
                    additionalInput = true
                } else {
                if Date().get(.day) == habitsUserData.date.get(.day) {
                    
                    habitsUserData.data += 1
                    } else {
                        
                        habitsUserData.data = 0.0
                    }
                
               
                
                userData.append(filteredForDate.last ?? UserData(id: "", type: .Habit, title: "", date: Date(), data: 0.0, goal: 0.0))
               
                }
                }
        
            .sheet(isPresented: $additionalInput, content: {
                VStack {
                    
                    TextField("Value", value: $filteredForDate.first?.data ?? $value, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                }
            })
                
                .sheet(isPresented: $details, content: {
                    if #available(iOS 15, *) {
                        DataView(userData: $userData, habitUserData: $habitsUserData, gridButton: GridButton(title: "Score and Habits", image: Image("")), tutorialNum: $tutorialNum, isTutorial: $isTutorial)
                    } else {
                        // Fallback on earlier versions
                    }
                })
                .onChange(of:  userData, perform: { value in
                    
                   
                    progress = Double(habitsUserData.data/(habitsUserData.goal))
                    
                    
                })
        }
    }

