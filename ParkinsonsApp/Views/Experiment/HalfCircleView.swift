//
//  HalfCircleView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/5/21.
//

import SwiftUI

struct HalvedCircularBar: View {
    
    @State var progress: CGFloat = 0.25
    @State var min: CGFloat = 0.2
    @State var max: CGFloat = 0.4
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    Circle()
                        .trim(from: 0.0, to: 0.705)
                        .stroke(Color("teal"), lineWidth: 20)
                        .opacity(0.4)
                        .frame(width: 200, height: 200)
                        .rotationEffect(Angle(degrees: -215))
                    Circle()
                        .trim(from: min, to: max)
                        .stroke(Color("teal"), lineWidth: 20)
                        .frame(width: 200, height: 200)
                        .rotationEffect(Angle(degrees: -215))
                    
                    Text("\(Int((self.progress)*100))")
                        .font(.custom("Poppins-Bold", size: 22, relativeTo: .headline))
                        .foregroundColor(Color("blue"))
                    VStack {
                        Spacer()
                        HStack {
                            Text("0")
                                .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                                .foregroundColor(Color("blue"))
                            Spacer()
                            Text("100")
                                .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                                .foregroundColor(Color("blue"))
                            
                        } .padding(.horizontal, 110)
                        
                    } .padding(.bottom, geo.size.height/5)
                }
            }
            
        }
    }
    
    func startLoading() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            withAnimation() {
                self.progress += 0.01
                if self.progress >= 1.0 {
                    timer.invalidate()
                }
            }
        }
    }
}
