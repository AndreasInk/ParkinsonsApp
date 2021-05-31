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
    @State var moreData = false
    @State var i = 0
    @Binding var days: [Day]
    
    @State var isTutorial = false
    @State var tutorialNum = 0
    var body: some View {
        ScrollView {
        VStack {
            HStack {
                DismissSheetBtn()
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
            HStack {
                Spacer()
//            Button(action: {
//                
//                moreData = true
//            }) {
//                HStack {
//                    Image(systemName: "chart.bar")
//                        .padding()
//                        .font(.headline)
//                        .foregroundColor(Color("blue"))
//                    Text("More Data")
//                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
//                }
//            }
        } .sheet(isPresented: $moreData, content: {
            DataView(days: $days, gridButton: GridButton(title: "Score and Meds", image: Image("")), tutorialNum: $tutorialNum, isTutorial: $isTutorial)
        })
            
        
            MedsWeekChartView(week: $week, med: $med)
            WeekChartView(week: $week)
            Stepper(value: $med.amountTaken, in: 0...1000) {
                Text("Amount Taken Today: " + String(med.amountTaken) + " " + med.unit)
                    .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
                    
            }
          
        } .padding()
       
        }
    }
}

