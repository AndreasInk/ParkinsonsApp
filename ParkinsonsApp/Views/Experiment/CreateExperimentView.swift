//
//  CreateExperimentView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/5/21.
//

import SwiftUI

struct CreateExperimentView: View {
    @State var experiment = Experiment(id: UUID(), title: "", description: "", users: [User](), groupScore: [PredictedScore](), posts: [Post](), week: [Week]())
    @State var habitTitle = ""
    var body: some View {
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

struct CreateExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        CreateExperimentView()
    }
}
