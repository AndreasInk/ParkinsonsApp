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
    var body: some View {
        HStack {
            VStack {
            Text(med.name)
                .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                Text(String(med.amountNeeded) + " " + med.unit)
                    .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
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
            MedsDetailsView(med: $med, week: $week)
        })
    }
}
