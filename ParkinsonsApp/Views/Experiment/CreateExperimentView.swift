//
//  CreateExperimentView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/5/21.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
struct CreateExperimentView: View {
    
    @State var experiment  = Experiment(id: UUID(), date: Date(), title: "Running", description: "Will running improve our health?", users: [User](), usersIDs: [String](), groupScore: [PredictedScore](), posts: [Post(id: UUID(), title: "Hello world", text: "Hi there", createdBy: User(id: UUID(), name: "Steve", experiments: [Experiment](), createdExperiments: [Experiment](), posts: [Post]()), comments: [Post(id: UUID(), title: "", text: "Good morning", createdBy: User(id: UUID(), name: "Andreas", experiments: [Experiment](), createdExperiments: [Experiment](), posts: [Post]()), comments: [Post]())])], week: [Week](), habit: [Habit](), imageName: "data2", upvotes: 0)
    @State var images = ["meal", "cook", "plate", "workout", "running", "nature", "hiking", "yoga", "mediation", "reading", "newspaper", "water", "call", "chat", "art", "edu", "data1", "data2", "data3", "data4", "data5", "data6", "data7", "data8", "data9", "data10"]
    @State var habitTitle = ""
    
    let columns = [
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80))
    ]
    @State var showImages = false
    
    @Binding var user: User
    
    @Binding var add: Bool
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Experiment Title")
                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .title))
                        .foregroundColor(Color("blue"))
                    Spacer()
                }
                TextField("Experiment Title", text: $experiment.title)
                    
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack {
                    Text("Experiment Description")
                        .foregroundColor(Color("blue"))
                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .title))
                    Spacer()
                }
                TextEditor(text: $experiment.description)
                    .frame(height: 150)
                    
                    
                    
                    .padding()
                    
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                    )
                
                HStack {
                    Text("Habit Name")
                        .foregroundColor(Color("blue"))
                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .title))
                    Spacer()
                }
                TextField("Habit Name", text: $habitTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    .onChange(of: habitTitle, perform: { value in
                        experiment.users.append(user)
                        experiment.habit = [Habit(id: UUID(), title: habitTitle, date: Date())]
                    })
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
                    experiment.users.append(user)
                    experiment.usersIDs.append(user.id.uuidString)
                    saveExperiment()
                    add = false
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .foregroundColor(Color("teal"))
                            .frame(height: 75)
                            .padding()
                        Text("Create")
                            .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                            .foregroundColor(.white)
                    }
                }
            }
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

