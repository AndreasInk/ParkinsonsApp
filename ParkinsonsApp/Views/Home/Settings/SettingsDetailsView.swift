//
//  SettingsDetailsView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/6/21.
//

import SwiftUI
import NiceNotifications

struct SettingsDetailsView: View {
    @Binding var setting: Setting
    @State var date1 = UserDefaults.standard.integer(forKey: "date1")
    @State var date2 = UserDefaults.standard.integer(forKey: "date2")
    @State var date3 = UserDefaults.standard.integer(forKey: "date3")
    
    @State var keyboard = UserDefaults.standard.bool(forKey: "keyboard")
    @State var openKeyboardSettings = UserDefaults.standard.bool(forKey: "openKeyboardSettings")
    @State var autoScroll = UserDefaults.standard.bool(forKey: "autoScroll")
    @State var buttonScroll = UserDefaults.standard.bool(forKey: "buttonScroll")
    @State var tapSens = UserDefaults.standard.double(forKey: "tapSens")
    
    var body: some View {
        switch setting.title {
        case "Notifications":
            VStack {
                Toggle(isOn: $setting.onOff) {
                    Text(setting.onOff ? "Disable Notifications" : "Enable Notifications")
                        .font(.custom("Poppins-Bold", size: 14, relativeTo: .subheadline))
                } .padding(.bottom)
                .onChange(of: setting.onOff, perform: { value in
                    if setting.onOff {
                        if date1 != 24 {
                        LocalNotifications.schedule(permissionStrategy: .askSystemPermissionIfNeeded) {
                            EveryDay(forDays: 365, starting: .today)
                                .at(hour: date1 , minute: 0)
                                .schedule(title: "Carry Your Phone", body: "to observe your health")
                        }
                        
                            }
                        if date2 != 24 {
                        LocalNotifications.schedule(permissionStrategy: .askSystemPermissionIfNeeded) {
                            EveryDay(forDays: 365, starting: .today)
                                .at(hour: date2 , minute: 0)
                                .schedule(title: "Carry Your Phone", body: "to observe your health")
                        }
                        
                            }
                        if date3 != 24 {
                        LocalNotifications.schedule(permissionStrategy: .askSystemPermissionIfNeeded) {
                            EveryDay(forDays: 365, starting: .today)
                                .at(hour: date3 , minute: 0)
                                .schedule(title: "Carry Your Phone", body: "to observe your health")
                        }
                        
                            }
                    } else {
                        let center = UNUserNotificationCenter.current()
                        center.removeAllPendingNotificationRequests()
                        center.removeAllDeliveredNotifications()
                    }
                })
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
                .onChange(of: date1, perform: { value in
                    UserDefaults().set(date1, forKey: "date1")
                    
                    if date1 != 24 {
                    LocalNotifications.schedule(permissionStrategy: .askSystemPermissionIfNeeded) {
                        EveryDay(forDays: 365, starting: .today)
                            .at(hour: date1 , minute: 0)
                            .schedule(title: "Carry Your Phone", body: "to observe your health")
                    }
                    
                        }
                    
                    
                })
                Stepper(value: $date2, in: 0...24) {
                    Text("Hour " + String(date2))
                        .font(.custom("Poppins-Bold", size: 14, relativeTo: .subheadline))
                } .padding(.bottom)
                .onChange(of: date2, perform: { value in
                    UserDefaults().set(date2, forKey: "date2")
                    if date2 != 24 {
                    LocalNotifications.schedule(permissionStrategy: .askSystemPermissionIfNeeded) {
                        EveryDay(forDays: 365, starting: .today)
                            .at(hour: date2 , minute: 0)
                            .schedule(title: "Carry Your Phone", body: "to observe your health")
                    }
                    
                        }
                })
                Stepper(value: $date3, in: 0...24) {
                    Text("Hour " + String(date3))
                        .font(.custom("Poppins-Bold", size: 14, relativeTo: .subheadline))
                } .padding(.bottom)
                .onChange(of: date3, perform: { value in
                    UserDefaults().set(date3, forKey: "date3")
                    if date3 != 24 {
                    LocalNotifications.schedule(permissionStrategy: .askSystemPermissionIfNeeded) {
                        EveryDay(forDays: 365, starting: .today)
                            .at(hour: date3 , minute: 0)
                            .schedule(title: "Carry Your Phone", body: "to observe your health")
                    }
                    
                        }
                })
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
                .onChange(of: keyboard, perform: { value in
                    UserDefaults().set(keyboard, forKey: "keyboard")
                })
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
                    .onChange(of: autoScroll, perform: { value in
                        UserDefaults().set(autoScroll, forKey: "autoScroll")
                    })
                    Toggle(isOn: $buttonScroll) {
                        Text(buttonScroll ? "Disable Button Scroll" : "Enable Button Scroll")
                            .font(.custom("Poppins-Bold", size: 14, relativeTo: .subheadline))
                    } .padding(.bottom)
                    .onChange(of: buttonScroll, perform: { value in
                        UserDefaults().set(buttonScroll, forKey: "buttonScroll")
                    })
                    HStack {
                    Text("Button Sensitivity")
                        .font(.custom("Poppins-Bold", size: 14, relativeTo: .subheadline))
                        Spacer()
                        
                    }
                    }
                    
                    Slider(value: $tapSens, in: -1...1)
                        .onChange(of: tapSens, perform: { value in
                            UserDefaults().set(tapSens, forKey: "tapSens")
                        })
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


