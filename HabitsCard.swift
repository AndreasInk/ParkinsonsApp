//
//  SwiftUIView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 6/4/21.
//

import SwiftUI

struct HabitsCard: View {
   
    @State var habitsUserData: [UserData] = []
    @Binding var userData: [UserData]
    @Binding var tutorialNum: Int
    @Binding var isTutorial: Bool
    @State var add = false
   
    @State var refresh = false
    var columns = [GridItem(.flexible(minimum: 80)), GridItem(.flexible(minimum: 80)), GridItem(.flexible(minimum: 80))]
    var body: some View {
        ZStack {
            Color.clear
                .onAppear() {
                    habitsUserData = userData.filter { data in
                        return data.type == .Habit
                    }
                   
                }
        HStack {
        ForEach($habitsUserData, id: \.self) { $data in
            HabitsCell(habitsUserData: $data, userData: $userData, tutorialNum: $tutorialNum, isTutorial: $isTutorial)
                .onAppear() {
                    print(data)
                }
        }
           
        
        .onChange(of: habitsUserData) { value in
            userData = userData.filter { data in
                return data.type != .Habit
            }
            userData.append(contentsOf: habitsUserData)
        }
        
        if habitsUserData.count < 3 {
            Button(action: {
            add = true
            }) {
                ZStack {
            Circle()

                .stroke(Color("teal"), style: StrokeStyle(lineWidth: CGFloat(5), lineCap: .round))

                    Image(systemName: "plus")
                        .foregroundColor(Color("blue"))
                        .font(.largeTitle)
                        .padding()
                }
            }.sheet(isPresented: $add, content: {
                CreateHabitView(habitsUserData: $habitsUserData)
            })
        }
    }
        } .padding(.vertical)
}
}



