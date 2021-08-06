//
//  CollectListView.swift
//  CollectListView
//
//  Created by Andreas on 8/5/21.
//

import SwiftUI

struct CollectListView: View {
    @Binding var habits: [Habit]
    @State var newHabit = Habit(id: UUID().uuidString, data: [UserData](), title: "")
    @State var showEditView = false
    @State var addHabit = false
    @State var showDetailsView = false
    @Binding var dataTypes: [String]
    var body: some View {
        NavigationView {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    addHabit = true
                }) {
                    Image(systemSymbol: .plus)
                        .font(.largeTitle)
                        .padding()
                } .buttonStyle(PlainButtonStyle())
            } .sheet(isPresented: $addHabit) {
                CollectDetailView(habit: $newHabit)
                    .onDisappear() {
                        if !newHabit.title.isEmpty {
                        habits.append(newHabit)
                        dataTypes.append(newHabit.title)
                        UserDefaults.standard.set(dataTypes, forKey: "types")
                        newHabit = Habit(id: UUID().uuidString, data: [UserData](), title: "")
                        }
                    }
            }
            
            
        List {
            ForEach($habits, id: \.id) { $habit in
                NavigationLink(destination: CollectDetailView(habit: $habit)) {
                    Text($habit.wrappedValue.title)
                        .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                    .padding()
                }
            }
        }
        }
        } 
    }
}

