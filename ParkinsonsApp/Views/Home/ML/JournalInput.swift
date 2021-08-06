//
//  JournalInput.swift
//  JournalInput
//
//  Created by Andreas on 8/4/21.
//

import SwiftUI

struct JournalInput: View {
    @Binding var userData: UserData
    var body: some View {
        VStack {
            HStack {
                Text("How are you feeling 1-10?")
                
                Spacer()
            } .padding()
          
            TextField("How are you feeling 1-10?", value: $userData.data, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .padding()
                .padding(.bottom)
            HStack {
                Text("Notes")
                
                Spacer()
            } .padding()
        TextEditor(text: $userData.text)
                .padding()
                
        } .padding()
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
    }
}

