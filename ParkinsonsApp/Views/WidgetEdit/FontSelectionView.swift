//
//  FontSelectionView.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import SwiftUI

struct FontSelectionView: View {
    @State var fonts = ["Poppins-Bold"]
    @Binding var color1: Color
    @Binding var color2: Color
    @Binding var textColor: Color
    @Binding var font: String
    var body: some View {
        ScrollView(.horizontal) {
        HStack {
            ForEach(fonts, id: \.self) { font in
                ZStack {
                    
                    LinearGradient(gradient: Gradient(colors: [(color1), (color2)]), startPoint: .leading, endPoint: .bottomTrailing)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        .frame(height: 60)
                    Text(font)
                        .font(.custom(font, size: 12, relativeTo: .subheadline))
                        .foregroundColor(textColor)
                        .padding()
                } .padding(.leading)
                .scaleEffect(self.font == font ? 0.8 : 1.0 )
                
                .onTapGesture {
                    withAnimation(.easeInOut) {
                    self.font = font
                    }
                }
            }
        }
        }
    }
}
