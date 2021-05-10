//
//  SettingsView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI

struct SettingsView: View {
    @Binding var settings: [Setting]
    @Binding var tutorialNum: Int
    @Binding var isTutorial: Bool
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ScrollView {
        VStack {
            if isTutorial {
                VStack {
                   
                    Text("Tap the arrow to the right of each setting to learn more about them and set the settings to your desired setting.")
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                        .padding()
                    HStack {
                    Button(action: {
                    tutorialNum += 1
                    presentationMode.wrappedValue.dismiss()
                        settings.append( Setting(title: "Share With Your Doctor", text: "Export your data to your doctor to give important insights to your doctor to help you.", onOff: true))
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25.0)
                                .foregroundColor(Color(.lightGray))
                                .frame(height: 75)
                                .padding()
                            Text("Next")
                                .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                                .foregroundColor(.white)
                        }
                    } .buttonStyle(CTAButtonStyle())
                        Spacer()
                    }
            }
            }
            if !isTutorial {
                DismissSheetBtn()
                    .onAppear() {
                        if !settings.map({$0.title}).contains("Share With Your Doctor") {
                        settings.append( Setting(title: "Share With Your Doctor", text: "Export your data to your doctor to give important insights to your doctor to help you.", onOff: true))
                    }
                        if !settings.map({$0.title}).contains("Share Your Data") {
                        settings.append(Setting(title: "Share Your Data", text: "By sharing your data, we can make scoring even better!  ", onOff: true))
                    }
                    }
            }
            ForEach(settings.indices, id: \.self) { i in
                SettingsRow(setting: $settings[i])
                    .disabled(isTutorial ? true : false)
                Divider()
            }
            .onChange(of: settings, perform: { value in
                let encoder = JSONEncoder()
                settings = settings.removeDuplicates()
                if let encoded = try? encoder.encode(settings.removeDuplicates()) {
                    if let json = String(data: encoded, encoding: .utf8) {
                        
                        do {
                            let url = self.getDocumentsDirectory().appendingPathComponent("settings.txt")
                            try json.write(to: url, atomically: false, encoding: String.Encoding.utf8)
                            
                        } catch {
                            print("erorr")
                        }
                    }
                    
                    
                }
            })
            Spacer()
        }
           
        }
    }
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}



