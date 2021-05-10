//
//  MedsRow.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/7/21.
//

import SwiftUI

struct MedsRow: View {
    @Binding var med: Med
    @State var open: Bool = false
    @Binding var week: Week
    @Binding var days: [Day]
    var body: some View {
        HStack {
            VStack {
                HStack {
            Text(med.name)
                .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                    Spacer()
                }
                HStack {
                Text(String(med.amountNeeded) + " " + med.unit)
                    .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
                    Spacer()
            }
            }
            Spacer()
            Button(action: {
                open = true
            }) {
                Image(systemName: "arrow.right")
                    .font(.title)
            }
        } .padding()
        .sheet(isPresented: $open, content: {
            MedsDetailsView(med: $med, week: $week, days: $days)
        })
    }
}
