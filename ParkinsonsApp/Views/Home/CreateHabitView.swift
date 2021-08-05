//
//  CreateHabitView.swift
//  CreateHabitView
//
//  Created by Andreas on 7/19/21.
//

import SwiftUI

struct CreateHabitView: View {
    @Binding var habitsUserData: [UserData]
    @State var habit = UserData(id: UUID().uuidString, type: .Habit, title: "", date: Date(), data: 0.0, goal: 0.0)
    @State var isExperiment = false
    var body: some View {
        if isExperiment {
            
        } else {
        VStack {
           
                Text("Habit Name")
                    .foregroundColor(Color("blue"))
                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .title))
               
            
            TextField("Habit Name", text: $habit.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Habit Goal Per Day", value: $habit.goal, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            Text("Goal: \(habit.title) \(habit.goal) times a day ")
                .font(.custom("Poppins-Bold", size: 12, relativeTo: .headline))
                
                            
            Spacer()
        }
        .onDisappear() {
            if !habit.title.isEmpty  {
            habitsUserData.append(habit)
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(habitsUserData) {
                if let json = String(data: encoded, encoding: .utf8) {
                  
                    do {
                        let url = self.getDocumentsDirectory().appendingPathComponent("habitsUserData.txt")
                        try json.write(to: url, atomically: false, encoding: String.Encoding.utf8)
                        
                    } catch {
                        print("erorr")
                    }
                }
                
            }
            }
            
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

