//
//  SettingsRow.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/6/21.
//

import SwiftUI

struct SettingsRow: View {
    @Binding var setting: Setting
    @State var open = false
    var body: some View {
        HStack {
            VStack {
                HStack {
            Text(setting.title)
                .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                .padding(.vertical)
                  Spacer()
                }
                HStack {
                Text(setting.text)
                    
                    .font(.custom("Poppins-Bold", size: 14, relativeTo: .subheadline))
                    Spacer()
            }
            }
            Spacer()
           
            Button(action: {
                open = true
            }) {
                Image(systemName: "arrow.right")
                    .font(.title)
            }

        } .padding()
            .sheet(isPresented: $open, content: {
                SettingsDetailsView(setting: $setting)
            })
    }
}

