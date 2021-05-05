//
//  PostView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/5/21.
//

import SwiftUI

struct PostView: View {
    @State var post: Post
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
            Divider()
            ForEach(post.comments, id: \.self) { comment in
                HStack {
                    Text(comment.createdBy.name)
                        .font(.custom("Poppins-Bold", size: 14, relativeTo: .subheadline))
                    Spacer()
                Text(comment.text)
                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .subheadline))
                    
                }
                Divider()
            }
        } .padding()
    }
}


