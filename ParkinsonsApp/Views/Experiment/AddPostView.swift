//
//  AddPostView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/5/21.
//

import SwiftUI

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
struct AddPostView: View {
    
    @Binding var experiment: Experiment
    
    @State var habitTitle = ""
    @State var post = Post(id: UUID(), title: "", text: "", createdBy: User(id: UUID(), name: "", experiments: [Experiment](), createdExperiments: [Experiment](), posts: [Post]()), comments: [Post]())
    let columns = [
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80))
    ]
    @State var showImages = false
    
    @Binding var user: User
    @Binding var addPost: Bool
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Post Title")
                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .title))
                        .foregroundColor(Color("blue"))
                    Spacer()
                }
                TextField("Post Title", text: $post.title)
                    
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack {
                    Text("Post Text")
                        .foregroundColor(Color("blue"))
                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .title))
                    Spacer()
                }
                TextEditor(text: $post.text)
                    .frame(height: 150)
                    
                    
                    
                    .padding()
                    
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                    )
                
                
                Spacer()
                Button(action: {
                    experiment.posts.append(post)
                    saveExperiment()
                    addPost = false
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

