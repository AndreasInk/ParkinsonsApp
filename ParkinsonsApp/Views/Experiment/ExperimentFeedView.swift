//
//  ExperimentFeedView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/5/21.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
struct ExperimentFeedView: View {
    @Binding var user: User
    @State var i = 0
    @State var experiments = [Experiment]()
    @State var add = false
    @State var refresh = false
    
    @Binding var tutorialNum: Int
    @Binding var isTutorial: Bool
    var body: some View {
        ZStack {
            Color.clear
                .onAppear() {
                    
                    
                    self.loadUsersExperiments() { experiments in
                        self.experiments = experiments
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
                        CreateExperimentView(user: $user, add: $add)
                    })
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button(action: {
                        if !refresh {
                            i = 0
                            refresh = true
                            
                            self.loadUsersExperiments() { experiments in
                                self.experiments = experiments
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    refresh = false
                                }
                            }
                        }
                    }) {
                        Text("Your Habits")
                            .font(.custom("Poppins-Bold", size: 16, relativeTo: .subheadline))
                            .foregroundColor(i == 0 ? Color("teal") : Color(.gray).opacity(0.4))
                    } .frame(width: 100)
                    Spacer()
//                    Button(action: {
//                        if !refresh {
//                            i = 1
//                            refresh = true
//                            
//                            self.loadPopularExperiments() { experiments in
//                                self.experiments = experiments
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                                    refresh = false
//                                }
//                            }
//                        }
//                    }) {
//                        Text("Popular")
//                            .font(.custom("Poppins-Bold", size: 16, relativeTo: .subheadline))
//                            .foregroundColor(i == 1 ? Color("teal") : Color(.gray).opacity(0.4))
//                    } .frame(width: 100)
                    Spacer()
                    Button(action: {
                        if !refresh {
                            i = 2
                            refresh = true
                            
                            
                            self.loadRecentExperiments() { experiments in
                                self.experiments = experiments
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    refresh = false
                                }
                            }
                        }
                    }) {
                        Text("Recent")
                            .font(.custom("Poppins-Bold", size: 16, relativeTo: .subheadline))
                            .foregroundColor(i == 2 ? Color("teal") : Color(.gray).opacity(0.4))
                    } .frame(width: 100)
                    Spacer()
                } .padding(.top)
                ScrollView {
                    VStack {
                        if !refresh {
                            ForEach(experiments.reversed().indices, id: \.self) { i in
                                if experiments.indices.contains(i) {
                                    ExperimentCard(user: $user, experiment: $experiments[i], tutorialNum: $tutorialNum, isTutorial: $isTutorial)
                                } else {
                                    EmptyView()
                                        .onAppear() {
                                            refresh = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                                withAnimation(.easeInOut) {
                                                    refresh = false
                                                }
                                            }
                                            
                                        }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    func loadRecentExperiments(performAction: @escaping ([Experiment]) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("experiments")
        var userList = [Experiment]()
        let query = docRef.order(by: "date")
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
    func loadPopularExperiments(performAction: @escaping ([Experiment]) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("experiments")
        var userList = [Experiment]()
        let query = docRef.whereField("upvotes", isGreaterThan: 3)
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

