//
//  HomeView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI
import Charts

struct HomeView: View {
    @State var welcome = ["Welcome!", "Hello!", "Hello there!"]
    @State var share = false
    @State var settings = false
    @State var name = UserDefaults.standard.string(forKey: "name")
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 75, height: 75, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding()
                Spacer()
                
                Button(action: {
                    share.toggle()
                }) {
                    Image(systemName: "shippingbox")
                        .font(.largeTitle)
                        .padding()
                }
                .sheet(isPresented: $share, content: {
                    ShareView()
                })
                
                Button(action: {
                    settings.toggle()
                }) {
                    Image(systemName: "gear")
                        .font(.largeTitle)
                        .padding()
                }
                .sheet(isPresented: $settings, content: {
                    SettingsView()
                })
            }
            HStack {
            Text(welcome.randomElement() ?? "Hello there!" + (name ?? "Steve"))
            .bold()
            .font(.custom("Poppins-Bold", size: 24, relativeTo: .title))
            .foregroundColor(Color("blue"))
                .padding(.horizontal)
                Spacer()
            }
            //CardView()
            ButtonGridView()
            ChartView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
