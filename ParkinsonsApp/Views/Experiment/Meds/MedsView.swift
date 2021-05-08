//
//  MedsView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/7/21.
//

import SwiftUI

struct MedsView: View {
    @State var meds = [Med(id: UUID(), name: "patch", notes: "hello world", amountNeeded: 2.0,amountTaken: 2.0, unit: "ml", date: Date())]
   // @Binding var week: Week
    
    @State  var week = Week(id: UUID().uuidString,  sun: Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), mon:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), tue:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), wed:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), thur:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), fri:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), sat:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()))
    var body: some View {
        VStack {
        ForEach(meds.indices, id: \.self) { i in
            MedsRow(med: $meds[i], week: $week)
                .onChange(of: meds[i], perform: { value in
                  
                    let today = meds[i].date.get(.weekday)
                        print(meds[i])
                    print(today)
                        if today == 1 {
                            week.mon.meds.append(Med(id: UUID(), name: meds[i].name, notes: meds[i].notes, amountNeeded: meds[i].amountNeeded, amountTaken: meds[i].amountTaken, unit: meds[i].unit, date: meds[i].date))
                        } else if today == 2 {
                            
                            week.tue.meds.append(Med(id: UUID(), name: meds[i].name, notes: meds[i].notes, amountNeeded: meds[i].amountNeeded, amountTaken: meds[i].amountTaken, unit: meds[i].unit, date: meds[i].date))
                            
                        } else if today == 3 {
                            week.wed.meds.append(Med(id: UUID(), name: meds[i].name, notes: meds[i].notes, amountNeeded: meds[i].amountNeeded, amountTaken: meds[i].amountTaken, unit: meds[i].unit, date: meds[i].date))
                        } else if today == 4 {
                            week.thur.meds.append(Med(id: UUID(), name: meds[i].name, notes: meds[i].notes, amountNeeded: meds[i].amountNeeded, amountTaken: meds[i].amountTaken, unit: meds[i].unit, date: meds[i].date))
                        }  else if today == 5 {
                            week.fri.meds.append(Med(id: UUID(), name: meds[i].name, notes: meds[i].notes, amountNeeded: meds[i].amountNeeded, amountTaken: meds[i].amountTaken, unit: meds[i].unit, date: meds[i].date))
                            print(12232223)
                        }  else if today == 6 {
                            week.sat.meds.append(Med(id: UUID(), name: meds[i].name, notes: meds[i].notes, amountNeeded: meds[i].amountNeeded, amountTaken: meds[i].amountTaken, unit: meds[i].unit, date: meds[i].date))
                            print(12232223)
                        } else if today == 0 {
                            week.sun.meds.append(Med(id: UUID(), name: meds[i].name, notes: meds[i].notes, amountNeeded: meds[i].amountNeeded, amountTaken: meds[i].amountTaken, unit: meds[i].unit, date: meds[i].date))
                        
                        }
                })
        }
            Spacer()
        }
    }
}
