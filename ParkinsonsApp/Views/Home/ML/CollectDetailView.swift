//
//  CollectDetailView.swift
//  CollectDetailView
//
//  Created by Andreas on 8/5/21.
//

import SwiftUI

struct CollectDetailView: View {
    @Binding var habit: Habit
    @State var showEditView = false
    @State var refresh = false
    @State var chartData = ChartData(points: [Double]())
    @Binding var userData: [UserData]
    @Binding var dataTypes: [String]
    var body: some View {
       
        VStack {
            DayChartView(title: "", chartData: $chartData, refresh: $refresh, dataTypes: $dataTypes, userData: $userData)
//                .ignoresSafeArea(.all, edges: .top)
//                .padding()
//                .padding(.top)
            HStack {
                Spacer()
                    .onAppear() {
                        chartData =   ChartData(points: habit.data.map{$0.data})
                    }
            
                
            } .padding()
            
           
            HStack {
            Text("Title of Data:")
                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                Spacer()
            } .padding()
           
                TextField("Title", text: $habit.title)
                .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                    .padding(.bottom)
                    .padding()
            
            List {
                ForEach($habit.data, id: \.id) { $data in
                    NavigationLink(destination:  CollectEditView(userData: $data)) {
                        Text(data.title == "" ? "No Title" : data.title)
                            .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                            .padding()
                    }
                 
                }
            
        }
        } .navigationBarItems( trailing: Button(action: {
            habit.data.append(UserData(id: UUID().uuidString, type: .Health, title: "", text: "", date: Date(), data: 0.0))
        }) {
            Image(systemSymbol: .plus)
                .font(.title)
                .padding()
        })
    }
}


