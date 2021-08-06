//
//  CollectEditView.swift
//  CollectEditView
//
//  Created by Andreas on 8/5/21.
//

import SwiftUI
import SFSafeSymbols
struct CollectEditView: View {
    @Binding var userData: UserData
    @State var types = [String]()
    @State var addTag = false
    @State var tag = ""
    var body: some View {
        VStack {
            HStack {
            Text("Title of Data:")
                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                
                .onAppear() {
                    types.append(contentsOf: DataType.allCases.map{$0.rawValue})
                }
                Spacer()
            }  .padding()
                TextField("Title", text: $userData.title)
                .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                    .padding(.vertical)
                  
                    .padding()

            
        HStack {
            Text("Data:")
                .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
            Spacer()
        } .padding()
      
        TextField("Data", value: $userData.data, formatter: NumberFormatter())
            .keyboardType(.numberPad)
            .padding()
            .padding(.bottom)
            
            DatePicker("", selection: $userData.date, displayedComponents: .date)
                .datePickerStyle(CompactDatePickerStyle())
                .padding()
            Spacer()
        }
    }
}


