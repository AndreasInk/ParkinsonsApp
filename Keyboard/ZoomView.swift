//
//  ZoomView.swift
//  Keyboard
//
//  Created by Andreas on 4/23/21.
//

import SwiftUI

struct ZoomView: View {
    let columns = [
            GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80))
        ]
    @Binding var zoom: Bool
    @Binding var zoomSection: [String]
    @Binding var pressedKey: String
    @Binding var predictedKey: String
    var body: some View {
        GeometryReader { geo in
        VStack {
           // Spacer(minLength: 200)
        LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(zoomSection, id: \.self) { key in
                            Button(action: {
                                pressedKey = key
                                zoom = false
                            }) {
                               
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color(predictedKey == key ? .link : .white))
                                Text(key)
                                    .bold()
                                    .font(.largeTitle)
                                    .foregroundColor(predictedKey == key ? .white : .black)
                            } .frame(width: geo.size.width/8, height: geo.size.width/8)
                        }
                    }
                    .padding(.horizontal)
    }
        } .padding(.top)
        }
}
}
