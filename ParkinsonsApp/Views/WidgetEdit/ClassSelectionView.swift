//
//  ClassSelectionView.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import SwiftUI

struct ClassSelectionView: View {
    @State var classes = ["Expirations", "Expenses"]
    @Binding var color1: Color
    @Binding var color2: Color
    @Binding var textColor: Color
    @Binding var course: String
    var body: some View {
        ScrollView(.horizontal) {
        HStack {
            ForEach(classes, id: \.self) { course in
                ZStack {
                    
                    LinearGradient(gradient: Gradient(colors: [(color1), (color2)]), startPoint: .leading, endPoint: .bottomTrailing)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        .frame(height: 60)
                    Text(course)
                        .font(.custom("Poppins-Bold", size: 12, relativeTo: .subheadline))
                        .foregroundColor(textColor)
                        .padding()
                } .padding(.leading)
                .scaleEffect(self.course == course ? 0.8 : 1.0 )
                .onTapGesture {
                    withAnimation(.easeInOut) {
                    self.course = course
                    }
                }
            }
        }
        }
    }
}


