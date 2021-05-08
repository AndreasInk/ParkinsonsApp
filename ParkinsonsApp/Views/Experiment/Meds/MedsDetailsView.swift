//
//  MedsDetailsView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/7/21.
//

import SwiftUI

struct MedsDetailsView: View {
    @Binding var med: Med
    @Binding var week: Week
    @State var edit = false
    @State var i = 0
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    edit.toggle()
                }) {
                    Text("Edit")
                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                }
            }
            .sheet(isPresented: $edit, content: {
                EditMedsView(med: $med, add: $edit)
            })
            Image(systemName: "pills")
                .font(.largeTitle)
                .padding(.bottom)
            Text(med.name)
                .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
            Text(med.notes)
                .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
                .padding(.bottom)
            
            Spacer()
            MedsWeekChartView(week: $week, med: $med)
            Stepper(value: $med.amountTaken, in: 0...1000) {
                Text("Amount Taken Today: " + String(med.amountTaken) + " " + med.unit)
                    .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
                    
            }
            .onDisappear() {
               
            }
        } .padding()
       
        
    }
}

