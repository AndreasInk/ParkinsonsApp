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
        Button(action: {
            open = true
        }) {
        HStack {
            VStack {
                HStack {
            Text(setting.title)
                .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                .padding(.vertical)
                .multilineTextAlignment(.leading)
                  Spacer()
                }
                HStack {
                Text(setting.text)
                        .multilineTextAlignment(.leading)
                    .font(.custom("Poppins-Bold", size: 14, relativeTo: .subheadline))
                    
                    Spacer()
            }
            }
            Spacer()
           
           
                Image(systemName: "arrow.right")
                    .font(.title)
            }

        } .padding()
            .sheet(isPresented: $open, content: {
                SettingsDetailsView(setting: $setting, openCard: $open)
            })
    }
}

