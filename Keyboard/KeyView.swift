//
//  KeyView.swift
//  Keyboard
//
//  Created by Andreas on 4/23/21.
//

import SwiftUI

struct KeyView: View {
    @State private var offset = CGSize.zero
    @Binding var pressedKey: String
    @Binding var zoom: Bool
    @Binding var key: Key
    @State var opacity = 1.0
    @Binding var zoomSection: [String]
    @State var section1 = ["q", "w", "e", "a", "s", "d", "z", "x"]
    @State var section2 = ["d", "x", "r", "t", "y", "u", "f", "g", "h", "c", "v", "b"]
    @State var section3 = ["i", "o", "p", "j", "k", "l", "n", "m"]
    @Binding var predictedKey: String
    @Binding var uppercase: Bool
    @Binding var uppercaseDoubleTap: Bool
    var body: some View {
        GeometryReader { geo in
        ZStack {
            Rectangle()
                .foregroundColor(zoom ? Color(.systemRed) : Color(.white))
            Text(key.key)
                .bold()
                .font(.title)
                .foregroundColor(.black)
        } .onTapGesture {
            print(key.sens)
            key.sens = 8.0
            uppercase = false
        }
        .onChange(of: uppercase, perform: { value in
            if uppercase {
                key.key = key.key.uppercased()
                section1 = section1.map{$0.uppercased()}
                section2 = section2.map{$0.uppercased()}
                section3 = section3.map{$0.uppercased()}
            } else {
                if uppercaseDoubleTap {
                    key.key = key.key.uppercased()
                    section1 = section1.map{$0.uppercased()}
                    section2 = section2.map{$0.uppercased()}
                    section3 = section3.map{$0.uppercased()}
                } else {
                key.key = key.key.lowercased()
                section1 = section1.map{$0.lowercased()}
                section2 = section2.map{$0.lowercased()}
                section3 = section3.map{$0.lowercased()}
            }
            }
        })
        .simultaneousGesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                .onChanged {_ in
                                    withAnimation(.easeIn) {
                                    opacity = 0.3
                                    }
                                }
                       .onEnded {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.easeIn) {
                            
                            opacity = 1.0
                        }
                        }
                       
                        let frame = geo.frame(in: CoordinateSpace.local)
                        print($0.location.y)
                        if frame.midX + CGFloat(key.sens) < $0.location.x {
                            zoom = true
                            if section1.contains(key.key) {
                               
                                predictedKey = key.key
                                zoomSection = section1
                               
                                
                            } else if section2.contains(key.key) {
                                
                                predictedKey = key.key
                                zoomSection = section2
                                
                            } else if section3.contains(key.key) {
                               
                                predictedKey = key.key
                                zoomSection = section3
                                
                        }
                            
                            print("x")
                           
                        } else  if frame.midY + CGFloat(key.sens) < $0.location.y {
//                        if frame.midX - CGFloat(key.sens) < $0.location.x {
//                            zoom = true
//                            if section1.contains(key.key) {
//                                opacity = 1.0
//                                predictedKey = key.key
//                                zoomSection = section1
//
//
//                            } else if section2.contains(key.key) {
//                                opacity = 1.0
//                                predictedKey = key.key
//                                zoomSection = section2
//
//                            } else if section3.contains(key.key) {
//                                opacity = 1.0
//                                predictedKey = key.key
//                                zoomSection = section3
//
//                        }
//
//                            print("zoom")
//                        }
                       
                            zoom = true
                            print("y")
                            if section1.contains(key.key) {
                                
                                predictedKey = key.key
                                zoomSection = section1
                               
                                
                            } else if section2.contains(key.key) {
                               
                                predictedKey = key.key
                                zoomSection = section2
                                
                            } else if section3.contains(key.key) {
                               
                                predictedKey = key.key
                                zoomSection = section3
                                
                        }
                            
                            print("zoom")
                        
                      
                        } else if frame.midY - CGFloat(key.sens)    > $0.location.y {
                            zoom = true
                            print("y")
                            if section1.contains(key.key) {
                                
                                predictedKey = key.key
                                zoomSection = section1
                               
                                
                            } else if section2.contains(key.key) {
                               
                                predictedKey = key.key
                                zoomSection = section2
                                
                            } else if section3.contains(key.key) {
                               
                                predictedKey = key.key
                                zoomSection = section3
                                
                        }
                            
                            print("zoom")
                        
                        } else if frame.midX - CGFloat(key.sens)    > $0.location.x {
                            zoom = true
                            print("x")
                            if section1.contains(key.key) {
                                
                                predictedKey = key.key
                                zoomSection = section1
                               
                                
                            } else if section2.contains(key.key) {
                               
                                predictedKey = key.key
                                zoomSection = section2
                                
                            } else if section3.contains(key.key) {
                               
                                predictedKey = key.key
                                zoomSection = section3
                                
                        }
                            
                            print("zoom")
                        } else {
                            pressedKey = key.key
                        }
//                        if frame.midY - CGFloat(key.sens) < $0.location.y {
//                            zoom = true
//                            print("Y down")
//                            if section1.contains(key.key) {
//                                opacity = 1.0
//                                predictedKey = key.key
//                                zoomSection = section1
//
//
//                            } else if section2.contains(key.key) {
//                                opacity = 1.0
//                                predictedKey = key.key
//                                zoomSection = section2
//
//                            } else if section3.contains(key.key) {
//                                opacity = 1.0
//                                predictedKey = key.key
//                                zoomSection = section3
//
//                        }
//
//                            print("zoom")
//                        }
                       
                       })
        .opacity(opacity)
        .clipShape(RoundedRectangle(cornerRadius: 8))
       
    }
    }
}

