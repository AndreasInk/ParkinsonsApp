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
    @State var experiments2 = [Experiment]()
    @State var add = false
    @State var refresh = true
    
    @Binding var tutorialNum: Int
    @Binding var isTutorial: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var buttonScroll = UserDefaults.standard.bool(forKey: "buttonScroll2")
    @State var scrollI = 0
    var body: some View {
        ZStack {
            Color.clear
                .onAppear() {
                    //experiments = user.experiments
                    self.loadUsersExperiments() { experiments in
                        self.experiments = experiments
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            refresh = false
                        }
                    }
                    self.loadRecentExperiments() { experiments in
                        self.experiments2 = experiments
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            refresh = false
                        }
                    }
                }
            
            VStack {
                if isTutorial {
                    VStack {
                       
                        Text("Tap recents at the top to select experiments to join, an experiemnt is a group looking to make friends and help eachother improve by changing their habits, after the tutorial, you can press recent and join to join an experiment")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                            .padding()
                        
                        Button(action: {
                        tutorialNum += 1
                        presentationMode.wrappedValue.dismiss()
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .foregroundColor(Color(.lightGray))
                                    .frame(height: 75)
                                    .padding()
                                Text("Next")
                                    .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                                    .foregroundColor(.white)
                            }
                        } .buttonStyle(CTAButtonStyle())
                }
                }
                
                HStack {
                    if !isTutorial {
                        DismissSheetBtn()
                    }
                    Spacer()
                    Button(action: {
                        add = true
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .font(.title)
                            .foregroundColor(Color("blue"))
                    }  .disabled(isTutorial ? true : false)
                    .sheet(isPresented: $add, content: {
                        CreateExperimentView(user: $user, add: $add, experiments: $experiments, refresh: $refresh)
                    })
                   
                }
                HStack {
                    Spacer()
                    Button(action: {
                        i = 0
                        if !refresh {
                           
                            refresh = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                refresh = false
                            }
                        }
                    }) {
                        Text("Your Habits")
                            .font(.custom("Poppins-Bold", size: 16, relativeTo: .subheadline))
                            .foregroundColor(i == 0 ? Color("teal") : Color(.gray).opacity(0.4))
                    } .frame(width: 100)
                    .disabled(isTutorial ? true : false)
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
                        i = 2
                        if !refresh {
                           
                            refresh = true
                            
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                refresh = false
                            }
                        }
                    }) {
                        Text("Recent")
                            .font(.custom("Poppins-Bold", size: 16, relativeTo: .subheadline))
                            .foregroundColor(i == 2 ? Color("teal") : Color(.gray).opacity(0.4))
                    } .frame(width: 100)
                    .disabled(isTutorial ? true : false)
                    Spacer()
                } .padding(.top)
                ScrollView {
                    ScrollViewReader { value in
                    VStack {
                        
                      
                        if !refresh {
                            if i == 2 ? experiments2.isEmpty : experiments.isEmpty {
                                Spacer()
                                Image("data5")
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                                Button(action: {
                                add = true
                                }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 25.0)
                                            .foregroundColor(Color("teal"))
                                            .frame(height: 75)
                                            .padding()
                                        Text("Add an Experiment")
                                            .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                                            .foregroundColor(.white)
                                    }
                                } .buttonStyle(CTAButtonStyle())
                            } else {
                            ForEach(i == 2 ? experiments2.reversed().indices : experiments.reversed().indices, id: \.self) { i in
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
                    } .onChange(of: scrollI) { newValue in
                        value.scrollTo(newValue)
                    }
                    }
                }
               
            }
            if buttonScroll {
                VStack {
                    ScrollUpBtn(i: $scrollI)
                    Spacer()
                    ScrollDownBtn(i: $scrollI)
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

