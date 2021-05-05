//
//  CreateExperimentView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/5/21.
//

import SwiftUI

struct CreateExperimentView: View {
    @State var experiment = Experiment(id: UUID(), title: "", description: "", users: [User](), groupScore: [PredictedScore](), posts: [Post](), week: [Week]())
    @State var images = ["meal", "cook", "plate", "workout", "running", "nature", "hiking", "yoga", "mediation", "reading", "newspaper", "water", "call", "chat", "art", "edu", "data1", "data2", "data3", "data4", "data5", "data6", "data7", "data8", "data9", "data10"]
    @State var habitTitle = ""
    
    let columns = [
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80))
        ]
    @State var showImages = false
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
}

struct CreateExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        CreateExperimentView()
    }
}
