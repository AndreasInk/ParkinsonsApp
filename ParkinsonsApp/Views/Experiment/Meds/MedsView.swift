//
//  MedsView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/7/21.
//

import SwiftUI

struct MedsView: View {
    @State var meds = [Med]()
   // @Binding var week: Week
   
    @State var add = false
    @State  var week = Week(id: UUID().uuidString,  sun: Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), mon:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), tue:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), wed:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), thur:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), fri:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()), sat:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), habit: [Habit](), date: Date(), totalScore: 0.0, meds: [Med]()))
    
    
    var body: some View {
        ZStack {
            Color.clear
                .onAppear() {
                    let url = self.getDocumentsDirectory().appendingPathComponent("meds.txt")
                    do {
                        
                        let input = try String(contentsOf: url)
                        
                        
                        let jsonData = Data(input.utf8)
                        do {
                            let decoder = JSONDecoder()
                            
                            do {
                                let note = try decoder.decode([Med].self, from: jsonData)
                                
                                
                                meds = note
                                
                                
                                meds =  meds.removeDuplicates()
                               
                                //                                if i.first!.id == "1" {
                                //                                    notes.removeFirst()
                                //                                }
                                
                                
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    } catch {
                        print(error.localizedDescription)
                        
                    }
                    
                }
        VStack {
            HStack {
                
                Button(action: {
                    add = true
                }) {
                    Image(systemName: "plus")
                        .padding()
                        .font(.title)
                        .foregroundColor(Color("blue"))
                }
                .sheet(isPresented: $add, content: {
                    CreateMedView(meds: $meds, add: $add)
                })
                Spacer()
            }
        ForEach(meds.indices, id: \.self) { i in
            MedsRow(med: $meds[i], week: $week)
                
               
        }
            Spacer()
                .onChange(of: meds, perform: { value in
                    for i in meds.indices {
                        print(i)
                    let today = meds[i].date.get(.weekday)
                        print(meds[i])
                    print(today)
                        if today == 2 {
                            week.mon.meds.append(Med(id: UUID(), name: meds[i].name, notes: meds[i].notes, amountNeeded: meds[i].amountNeeded, amountTaken: meds[i].amountTaken, unit: meds[i].unit, date: meds[i].date))
                        } else if today == 3 {
                            
                            week.tue.meds.append(Med(id: UUID(), name: meds[i].name, notes: meds[i].notes, amountNeeded: meds[i].amountNeeded, amountTaken: meds[i].amountTaken, unit: meds[i].unit, date: meds[i].date))
                            
                        } else if today == 4 {
                            week.wed.meds.append(Med(id: UUID(), name: meds[i].name, notes: meds[i].notes, amountNeeded: meds[i].amountNeeded, amountTaken: meds[i].amountTaken, unit: meds[i].unit, date: meds[i].date))
                        } else if today == 5 {
                            week.thur.meds.append(Med(id: UUID(), name: meds[i].name, notes: meds[i].notes, amountNeeded: meds[i].amountNeeded, amountTaken: meds[i].amountTaken, unit: meds[i].unit, date: meds[i].date))
                        }  else if today == 6 {
                            week.fri.meds.append(Med(id: UUID(), name: meds[i].name, notes: meds[i].notes, amountNeeded: meds[i].amountNeeded, amountTaken: meds[i].amountTaken, unit: meds[i].unit, date: meds[i].date))
                            print(12232223)
                        }  else if today == 7 {
                            week.sat.meds.append(Med(id: UUID(), name: meds[i].name, notes: meds[i].notes, amountNeeded: meds[i].amountNeeded, amountTaken: meds[i].amountTaken, unit: meds[i].unit, date: meds[i].date))
                            print(12232223)
                        } else if today == 1 {
                            week.sun.meds.append(Med(id: UUID(), name: meds[i].name, notes: meds[i].notes, amountNeeded: meds[i].amountNeeded, amountTaken: meds[i].amountTaken, unit: meds[i].unit, date: meds[i].date))
                        
                        }
                    let encoder = JSONEncoder()
                    meds = meds.removeDuplicates()
                    if let encoded = try? encoder.encode(meds.removeDuplicates()) {
                        if let json = String(data: encoded, encoding: .utf8) {
                            
                            do {
                                let url = self.getDocumentsDirectory().appendingPathComponent("meds.txt")
                                try json.write(to: url, atomically: false, encoding: String.Encoding.utf8)
                                
                            } catch {
                                print("erorr")
                            }
                        }
                        
                    }
                    }
                })
        }
        }
        
    }
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}
