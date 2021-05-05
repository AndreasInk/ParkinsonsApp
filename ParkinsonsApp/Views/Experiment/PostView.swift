//
//  PostView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/5/21.
//

import SwiftUI

struct PostView: View {
    @State var post: Post
    @State var addComment = false
    @State var comment = Post(id: UUID(), title: "", text: "", createdBy: User(id: UUID(), name: "", experiments: [Experiment](), createdExperiments: [Experiment](), posts: [Post]()), comments: [Post]())
    var body: some View {
        VStack {
            HStack {
                Text(post.createdBy.name)
                .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                Spacer()
            }
        HStack {
        Text(post.title)
            .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
            Spacer()
        }
       
        HStack {
        Text(post.text)
            .font(.custom("Poppins-Bold", size: 16, relativeTo: .subheadline))
            Spacer()
    }
        .padding(.bottom)
        .padding(.bottom)
            
            HStack {
                Spacer()
                Button(action: {
                    addComment.toggle()
                }) {
                    HStack {
                    Image(systemName: "plus")
                        .padding()
                        .font(.headline)
                        .foregroundColor(Color("blue"))
                    
                    Text("Comment")
                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                }
                }
            }
            if addComment {
                HStack {
                TextEditor(text: $comment.text)
                    .frame(height: 100)
                    
                    
                    
                    .padding()
                   
                    .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                        )
                    Button(action: {
                        post.comments.append(comment)
                        addComment.toggle()
                        comment.comments.removeAll()
                    }) {
                        HStack {
                        Image(systemName: "plus")
                            .padding()
                            .font(.headline)
                            .foregroundColor(Color("blue"))
                        
                    }
                    }
                }
            }
            Divider()
            ForEach(post.comments, id: \.self) { comment in
                HStack {
                    Text(comment.createdBy.name)
                        .font(.custom("Poppins-Bold", size: 14, relativeTo: .subheadline))
                    Spacer()
                Text(comment.text)
                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .subheadline))
                    .fixedSize(horizontal: false, vertical: true)
                    
                }
                Divider()
            }
            
        } .padding()
    }
}


