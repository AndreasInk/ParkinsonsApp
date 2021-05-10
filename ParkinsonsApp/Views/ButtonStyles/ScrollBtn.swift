//
//  ScrollBtn.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/10/21.
//

import SwiftUI

struct ScrollDownBtn: View {
    @Binding var i: Int
    var body: some View {
      
        Button(action: {
            i += 1
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
            Text("Scroll Down")
                .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                .foregroundColor(.white)
            } .padding()
        }
    }
}

struct ScrollUpBtn: View {
    @Binding var i: Int
    var body: some View {
      
        Button(action: {
            i -= 1
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
            Text("Scroll Up")
                .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                .foregroundColor(.white)
        } .padding()
    }
    }
}


