//
//  SettingsView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI

struct SettingsView: View {
    @State var settings = [Setting(title: "Notifications", text: "We'll send notifications to remind you to keep your phone in your pocket to gain insights and send updates on habits", onOff: true, dates: [9]), Setting(title: "Accessability ", text: "Enable these features to make it easier to use the app", onOff: true), Setting(title: "Customize Your Widget", text: "You track your score on your home screen with widgets", onOff: true), Setting(title: "Share Your Experience ", text: "By sharing your experience with the app, we can make it even better!  ", onOff: true), Setting(title: "Share Your Data ", text: "By sharing your data, we can make scoring even better!  ", onOff: true), Setting(title: "Share With Your Doctor ", text: "Export your data to your doctor to give important insights to your doctor to help you.", onOff: true)]

    var body: some View {
        ScrollView {
        VStack {
            ForEach(settings.indices, id: \.self) { i in
                SettingsRow(setting: $settings[i])
                Divider()
            }
            Spacer()
        }
           
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
