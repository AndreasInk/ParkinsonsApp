//
//  SettingsView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI

struct SettingsView: View {
    @Binding var settings: [Setting]

    var body: some View {
        ScrollView {
        VStack {
            ForEach(settings.indices, id: \.self) { i in
                SettingsRow(setting: $settings[i])
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



