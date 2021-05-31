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
    
    @State var experiment  = Experiment(id: UUID(), date: Date(), title: "Running", description: "Will running improve our health?", users: [User](), usersIDs: [String](), groupScore: [PredictedScore](), posts: [Post](), week: [Week](), habit: [Habit](), imageName: "data2", upvotes: 0)
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
    
    @Binding var experiments: [Experiment]
    
    @State var created = false
    
    @Binding var refresh: Bool
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
                    created = true
                    
                    refresh = true
                    self.loadUsersExperiments() { experiments in
                        self.experiments.removeAll()
                        self.experiments = experiments
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            refresh = false
                        }
                    }
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
            .sheet(isPresented: $created, content: {
                ZStack {
                VStack {
                    DismissSheetBtn()
                    Spacer()
                Text("Created Your Experiment!")
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
    func loadUsersExperiments(performAction: @escaping ([Experiment]) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("experiments")
        var userList = [Experiment]()
        let query = docRef.whereField("usersIDs", arrayContains: user.id.uuidString)
        query.getDocuments { (documents, error) in
            if !(documents?.isEmpty ?? true) {
                for document in documents!.documents {
                    let result = Result {
                        try document.data(as: Experiment.self)
                    }
                    
                    switch result {
                    case .success(let user):
                        if let user = user {
                            userList.append(user)
                            
                        } else {
                            
                            print("Document does not exist")
                        }
                    case .failure(let error):
                        print("Error decoding user: \(error)")
                    }
                    
                    
                }
            }
            performAction(userList)
        }
    }
}

