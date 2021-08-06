//
//  CardView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI
import CodableCSV
import HealthKit
import CoreML
import FirebaseStorage

struct CardView: View {
    @State var image = "doc"
    @State var text = "Share your data with your doctor"
    @State var cta = "Export Data"
    @Environment(\.presentationMode) var presentationMode
    @State var open = false

    @State var userData = [UserData(id: UUID().uuidString, type: .Habit, title: "", text: "", date: Date(), data: 0.0)]
    private let healthStore = HKHealthStore()
    @State var loading = false
    @State var loaded =  false
    @State var progress = 0.0
    @State var premissionI = 0
    @State var q = false
    @State var canUse = false
    @State var hasParkinsons = false
    @State var done = false
    @Binding var openCard: Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color(.clear))
                .opacity(0.4)
        }
    }
}


