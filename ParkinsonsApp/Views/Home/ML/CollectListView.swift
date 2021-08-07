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
    @Binding var userData: [UserData]
    var body: some View {
        NavigationView {
        VStack {
        DismissSheetBtn()
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
                CollectDetailView(habit: $newHabit, userData: $userData, dataTypes: $dataTypes)
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
                NavigationLink(destination: CollectDetailView(habit: $habit, userData: $userData, dataTypes: $dataTypes)) {
                    Text($habit.wrappedValue.title)
                        .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                    .padding()
                }
            }
        }
        } .navigationBarHidden(true)
        } 
    }
}

