//
//  OnboardingView.swift
//  ParkinsonsApp
//
//  Created by Elliot Kantor on 5/6/21.
//

import SwiftUI
import NiceNotifications
import HealthKit

struct OnboardingView: View {
    let healthStore = HKHealthStore()
    @State var onboardingViews = [Onboarding(id: UUID(), image: "park", title: "Park", description: "Empowering Parkinson’s Patients with Mobility Metrics."), Onboarding(id: UUID(), image: "data1", title: "Learn From Your Data", description: "Data shows us what is working and what's not.  You can observe your score to track your condition and adapt accordingly."), Onboarding(id: UUID(), image: "chat2", title: "Learn From Others and Make Friends", description: "Meet new people and share ideas to improve your health."), Onboarding(id: UUID(), image: "running", title: "Create Experiments", description: "Start a new habit with others to motivate yourself and see what works in an experiment."), Onboarding(id: UUID(), image: "health", title: "Can we Access Your Mobility Metrics?", description: "We use this data to empower you to evaluate and track your condition, we do not save your raw data outside of your device, however if you join an experiment, the group's score will be saved off-device, or if you choose to share your data it will be stored off-device."), Onboarding(id: UUID(), image: "noti", title: "Can We Send You Notifications?", description: "We send notifications to remind you to place your phone in your pocket to observe your health and send social notifications.  You can turn notifications off in the settings of this app"), Onboarding(id: UUID(), image: "share2", title: "What's your name?", description: "")]
    @State var slideNum = 0
    @Binding var isOnboarding: Bool
    @Binding var isOnboarding2: Bool
    @State var time = 0
    @Binding var setting: Setting
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            TabView(selection: $slideNum) {
                ForEach(onboardingViews.indices, id: \.self) { i in
                    OnboardingDetail(onboarding: onboardingViews[i])
                        .tag(i)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            if onboardingViews[slideNum].title.contains("Can") {
            Button(action: {
                if slideNum + 1 < onboardingViews.count  {
                    slideNum += 1
                } else {
                    // dismiss sheet
                    presentationMode.wrappedValue.dismiss()
                }
                setting.onOff = false
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(Color(.lightGray))
                        .frame(height: 75)
                        .padding()
                    Text("No")
                        .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                        .foregroundColor(.white)
                }
            } .buttonStyle(CTAButtonStyle())
            }
            Button(action: {
                if onboardingViews[slideNum].title.contains("Noti") {
                    LocalNotifications.requestPermission(strategy: .askSystemPermissionIfNeeded) { success in
                        if success {
                            setting.onOff = true
                        }
                    }
                    
                } else if onboardingViews[slideNum].title.contains("Can we Access Your Mobility") {
                    let readData = Set([
                        HKObjectType.quantityType(forIdentifier: .walkingSpeed)!,
                        HKObjectType.quantityType(forIdentifier: .walkingStepLength)!,
                        HKObjectType.quantityType(forIdentifier: .walkingDoubleSupportPercentage)!,
                        HKObjectType.quantityType(forIdentifier: .walkingAsymmetryPercentage)!
                    ])
                    
                    self.healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
                        
                    }
                }
                if slideNum + 1 < onboardingViews.count  {
                    slideNum += 1
                } else {
                    // dismiss sheet
                    presentationMode.wrappedValue.dismiss()
                    
                }
                
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(Color("teal"))
                        .frame(height: 75)
                        .padding()
                    Text(onboardingViews[slideNum].title.contains("Can") ? "Yes" : "Continue")
                        .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                        .foregroundColor(.white)
                }
            } .buttonStyle(CTAButtonStyle())
            
        }
    }
}

struct OnboardingDetail: View {
    @State var onboarding: Onboarding
    @State var user = User(id: UUID(), name: "", experiments: [Experiment](), createdExperiments: [Experiment](), posts: [Post](), habit: [Habit]())
    var body: some View {
        VStack {
            Text(onboarding.title)
                .font(.custom("Poppins-Bold", size: 24, relativeTo: .title))
                .multilineTextAlignment(.center)
                .padding(.bottom)
                .fixedSize(horizontal: false, vertical: true)
            Text(onboarding.description)
                .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                .multilineTextAlignment(.center)
                .padding(.bottom)
                .fixedSize(horizontal: false, vertical: true)
            if onboarding.title == "What's your name?" {
                
                TextField("Name", text: $user.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onDisappear() {
                        let encoder = JSONEncoder()
                        
                        if let encoded = try? encoder.encode(user) {
                            if let json = String(data: encoded, encoding: .utf8) {
                              
                                do {
                                    let url = self.getDocumentsDirectory().appendingPathComponent("user.txt")
                                    try json.write(to: url, atomically: false, encoding: String.Encoding.utf8)
                                    
                                } catch {
                                    print("erorr")
                                }
                            }
                            
                            
                        }
                    }
            }
            
            Image(onboarding.image)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .rotation3DEffect(.degrees(3), axis: (x: 0, y: 1, z: 0))
                .shadow(color: Color(.lightGray).opacity(0.4), radius: 40)
        }
        .padding()
    }
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

