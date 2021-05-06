//
//  SettingsView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI

struct SettingsView: View {
    @State var settings = [Setting(title: "Notifications", text: "We'll send notifications to remind you to keep your phone in your pocket and send updates on habits", onOff: true, dates: [9]), Setting(title: "Accessability ", text: "Enable features to make it easier to use the app", onOff: true)]

    var body: some View {
        VStack {
            ForEach(settings.indices, id: \.self) { i in
                SettingsRow(setting: $settings[i])
                Divider()
            }
            Spacer()
            
           
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
