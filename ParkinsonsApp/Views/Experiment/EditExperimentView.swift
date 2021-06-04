//
//  EditExperimentView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 6/4/21.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
struct EditExperimentView: View {
    
    @Binding var experiment:  Experiment
    @State var images = ["meal", "cook", "plate", "workout", "running", "nature", "hiking", "yoga", "mediation", "reading", "newspaper", "water", "call", "chat", "art", "edu", "data1", "data2", "data3", "data4", "data5", "data6", "data7", "data8", "data9", "data10"]
    @State var habitTitle = ""
    
    let columns = [
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80))
    ]
    @State var showImages = false
    
   
    
    @Binding var add: Bool
    
    
    @State var created = false
    
    @Binding var refresh: Bool
    
    @State var goalPerDay = 0
    var body: some View {
        
        ScrollView {
            VStack {
                DismissSheetBtn()
                ExperimentTextEditor(experiment: $experiment)
                
                HStack {
                    Text("Habit Name")
                        .foregroundColor(Color("blue"))
                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .title))
                    Spacer()
                }
                TextField("Habit Name", text: $habitTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    .onChange(of: habitTitle, perform: { value in
                      
                        experiment.habit = [Habit(id: UUID(), title: habitTitle, date: Date())]
                    })
                Stepper(value: $goalPerDay, in: 0...1000) {
                    Text("Goal: \(habitTitle) \(goalPerDay) times a day ")
                        .font(.custom("Poppins-Bold", size: 12, relativeTo: .headline))
                        
                }
                Button(action: {
                    showImages.toggle()
                }) {
                    Text("Show images")
                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .title))
                        .foregroundColor(Color("teal"))
                }
                if showImages {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(images, id: \.self) { image in
                            Button(action: {
                                experiment.imageName = image
                                showImages = false
                            }) {
                                Image(image)
                                    .resizable()
                                    .scaledToFit()
                                
                            }
                        }
                    }
                }
                Spacer()
                Button(action: {
                    
                    #warning("Turned off Firebase")
                    //saveExperiment()
                    created = true
                    
                    refresh = true
                    
                    #warning("Turned off Firebase")
//                    self.loadUsersExperiments() { experiments in
//                        self.experiments.removeAll()
//                        self.experiments = experiments
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                            refresh = false
//                        }
//                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .foregroundColor(Color("teal"))
                            .frame(height: 75)
                            .padding()
                        Text("Save")
                            .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                            .foregroundColor(.white)
                    }
                }
            }
            .sheet(isPresented: $created, content: {
                ZStack {
                VStack {
                    DismissSheetBtn()
                    Spacer()
                Text("Saved Your Experiment!")
                    .font(.custom("Poppins-Bold", size: 24, relativeTo: .headline))
                    .onDisappear() {
                        add = false
                    }
                    Spacer()
                }
                    ForEach(0 ..< 20) { number in
                                        ConfettiView()
                                        }
                }
            })
            .padding()
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
    func saveExperiment() {
        let db = Firestore.firestore()
        do {
            try db.collection("experiments").document(experiment.id.uuidString).setData(from: experiment)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
    
}

