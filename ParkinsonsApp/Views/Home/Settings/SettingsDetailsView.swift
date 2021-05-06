//
//  SettingsDetailsView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/6/21.
//

import SwiftUI

struct SettingsDetailsView: View {
    @Binding var setting: Setting
    @State var date1 = 9
    @State var date2 = 24
    @State var date3 = 24
    
    @State var keyboard = false
    @State var openKeyboardSettings = false
    @State var autoScroll = false
    @State var buttonScroll = false
    @State var tapSens = 0.0
    
    var body: some View {
        switch setting.title {
        case "Notifications":
            VStack {
                Toggle(isOn: $setting.onOff) {
                    Text(setting.onOff ? "Disable Notifications" : "Enable Notifications")
                        .font(.custom("Poppins-Bold", size: 14, relativeTo: .subheadline))
                } .padding(.bottom)
                if setting.onOff {
                    HStack {
                    Text("Pick an hours to recieve notifications")
                        .font(.custom("Poppins-Bold", size: 14, relativeTo: .subheadline))
                        Spacer()
                    }
                    HStack {
                    Text("Select hour 24 to disable the notification")
                        .font(.custom("Poppins-Bold", size: 12, relativeTo: .subheadline))
                        Spacer()
                    } .padding(.bottom)
                Stepper(value: $date1, in: 0...24) {
                    Text("Hour " + String(date1))
                        .font(.custom("Poppins-Bold", size: 14, relativeTo: .subheadline))
                       
                } .padding(.bottom)
                    
                Stepper(value: $date2, in: 0...24) {
                    Text("Hour " + String(date2))
                        .font(.custom("Poppins-Bold", size: 14, relativeTo: .subheadline))
                } .padding(.bottom)
                Stepper(value: $date3, in: 0...24) {
                    Text("Hour " + String(date3))
                        .font(.custom("Poppins-Bold", size: 14, relativeTo: .subheadline))
                } .padding(.bottom)
                }
                Spacer()
            } .padding()
        case "Accessability":
            VStack {
               
                Toggle(isOn: $setting.onOff) {
                    Text(setting.onOff ? "Disable Accessability" : "Enable Accessability")
                        .font(.custom("Poppins-Bold", size: 14, relativeTo: .subheadline))
                } .padding(.bottom)
                if setting.onOff {
                    
                Toggle(isOn: $keyboard) {
                    Text(keyboard ? "Disable Keyboard" : "Enable Keyboard")
                        .font(.custom("Poppins-Bold", size: 14, relativeTo: .subheadline))
                } .padding(.bottom)
                    if keyboard {
                    Button(action: {
                       openKeyboardSettings = true
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25.0)
                                .foregroundColor(Color("teal"))
                                .frame(height: 75)
                                .padding()
                            Text("Keyboard Calibration")
                                .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                                .foregroundColor(.white)
                        }
                    }
                    }
                    Toggle(isOn: $autoScroll) {
                        Text(autoScroll ? "Disable Auto Scroll" : "Enable Auto Scroll")
                            .font(.custom("Poppins-Bold", size: 14, relativeTo: .subheadline))
                    } .padding(.bottom)
                    
                    Toggle(isOn: $buttonScroll) {
                        Text(buttonScroll ? "Disable Button Scroll" : "Enable Button Scroll")
                            .font(.custom("Poppins-Bold", size: 14, relativeTo: .subheadline))
                    } .padding(.bottom)
                    HStack {
                    Text("Button Sensitivity")
                        .font(.custom("Poppins-Bold", size: 14, relativeTo: .subheadline))
                        Spacer()
                    }
                    }
                    
                    Slider(value: $tapSens, in: -1...1)
                    
                Spacer()
            } .padding()
        case "Customize Your Widget":
            ConfigureWidgetView()
        case "Share Your Experience":
            CardView(image: "share2", text: "You can help other people with Parkinson's build better habits and track their health by sharing your experience to improve the app.", cta: "Share")
        case "Share Your Data":
            CardView(image: "share", text: "You can help other people with Parkinson's build better habits and track their health by sharing your data to improve our scoring feature.", cta: "Share")
        case "Share With Your Doctor":
            CardView()
        default:
            EmptyView()
        }
    }
}


