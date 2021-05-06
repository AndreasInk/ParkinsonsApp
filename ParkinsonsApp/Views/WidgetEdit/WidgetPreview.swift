//
//  WidgetPreview.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import SwiftUI

struct WidgetPreview: View {
    @Binding var color1: Color
    @Binding var color2: Color
    @Binding var textColor: Color
    @Binding var course: String
    @Binding var font: String
    @State var lastScore = UserDefaults(suiteName: "group.parkinsonsappv2.app")?.double(forKey: "lastScore")
    @State var beforeLastScore = UserDefaults(suiteName: "group.parkinsonsappv2.app")?.double(forKey: "beforeLastScore")
    @State var timeTillString = ""
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [((color1)), ((color2))]), startPoint: .leading, endPoint: .bottomTrailing)
                
                VStack {
                    HStack {
                    Text("Score")
                        .font(.custom(font, size: 18, relativeTo: .headline))
                        .foregroundColor(((textColor)))
                        Spacer()
                    }
                    HStack {
                        Text(String(lastScore ?? 0.0))
                        .font(.custom(font, size: 48, relativeTo: .title))
                        
                            .foregroundColor((textColor))
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        VStack {
                            HStack {
                        Text("Average")
                            .foregroundColor((textColor))
                            .font(.custom(font, size: 16, relativeTo: .subheadline))
                                Spacer()
                            }
                            HStack {
                                Text(String(beforeLastScore ?? 0.0))
                            .font(.custom(font, size: 16, relativeTo: .subheadline))
                            .foregroundColor((textColor))
                            
                                Spacer()
                            }
                        }
                        Spacer()
                        Text(lastScore ?? 0.0 < 0.2 ? "🎉" : "⚠️")
                            .font(.custom(font, size: 16, relativeTo: .subheadline))
    //                        .foregroundColor((textColor))
                        
                    }
                } .padding()
                
            }
        }
    }
