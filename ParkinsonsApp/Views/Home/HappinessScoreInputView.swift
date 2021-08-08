//
//  HappinessScoreInputView.swift
//  HappinessScoreInputView
//
//  Created by Andreas on 8/7/21.
//

import SwiftUI

struct HappinessScoreInputView: View {
    @Binding var habit: Habit
    @State var tapped = false
    var body: some View {
        VStack {
            HStack {
            Text("Happiness Score")
                .font(.custom("Poppins-Bold", size: 16, relativeTo: .subheadline))
                .padding()
                Spacer()
            }
        HStack {
            if habit.id ==  "Happiness Score" {
            ForEach(1...5, id:\.self) { i in
                Spacer()
                Button(action: {
                    habit.data.append(UserData(id: UUID().uuidString, type: .Health, title: habit.id, text: "", date: Date(), data: Double(i)))
                    tapped = true
                }) {
                 
                Text(String(i))
                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .subheadline))
                    .padding()
                    .foregroundColor(.white)
                    .background(Circle().foregroundColor(Color("blue")))
                
                } .scaleEffect(tapped ? (habit.data.last?.data == Double(i) ? 1.5 : 1) : 1)
            }
        }
            Spacer()
        }
    }
    }
}

