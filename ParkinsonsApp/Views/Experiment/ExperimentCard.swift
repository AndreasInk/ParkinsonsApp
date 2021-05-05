//
//  ExperimentCard.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/5/21.
//

import SwiftUI


struct ExperimentCard: View {
    @Binding var user: User
    @Binding var experiment: Experiment
    @State var open = false
    @State var disable = false
    var body: some View {
        ZStack {
            Color("blue")
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                
               // .blur(radius: 5)
         HStack {
    
            VStack {
               Spacer()
                HStack {
                    Text(experiment.title + " Experiment")
                        .fixedSize(horizontal: false, vertical: true)
                    .font(.custom("Poppins-Bold", size: 18, relativeTo: .subheadline))
                    .foregroundColor(Color(.white))
                    Spacer()
                }
               
                    Spacer()
                if !disable {
                HStack {
                    Button(action: {
                       
                        open = true
                    }) {
                        
                        
                        Text(experiment.users.map{$0.id}.contains(user.id) ? "Open" : "Join")
                            .font(.custom("Poppins-Bold", size: 16, relativeTo: .subheadline))
                            .foregroundColor(.white)
                            .padding()
                            .background(    RoundedRectangle(cornerRadius: 25.0)
                                                .foregroundColor(Color("teal")))
                        
                    } //.buttonStyle(cardStyle())
                    Spacer()
                }
                Spacer()
                }
            } .padding()
                
            Image(experiment.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 125, height: 125, alignment: .center)
        } .padding()
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
         .sheet(isPresented: $open) {
            ExperimentView(experiment: $experiment, user: $user)
        }

        } .padding(10)
}
}

