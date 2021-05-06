//
//  OnboardingView.swift
//  ParkinsonsApp
//
//  Created by Elliot Kantor on 5/6/21.
//

import SwiftUI

struct OnboardingView: View {
    @State var onboardingViews = [Onboarding(id: UUID(), image: "", title: "hello", description: "descript")]
    @State var slideNum = 1
    @Binding var isOnboarding: Bool
    var body: some View {
        VStack {
            TabView(selection: $slideNum) {
                ForEach(onboardingViews.indices, id: \.self) { i in
                    OnboardingDetail(onboarding: onboardingViews[i])
                        .tag(i)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            Button(action: {
                if slideNum < onboardingViews.count {
                    slideNum += 1
                } else {
                    // dismiss sheet
                    isOnboarding = false
                }
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(Color("teal"))
                        .frame(height: 75)
                        .padding()
                    Text("Continue")
                        .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct OnboardingDetail: View {
    @State var onboarding: Onboarding
    var body: some View {
        VStack {
            Text(onboarding.title)
                .font(.title)
            Text(onboarding.description)
                .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
            Image(onboarding.image)
        }
        .padding()
    }
}

