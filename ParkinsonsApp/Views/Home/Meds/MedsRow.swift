////
////  MedsRow.swift
////  ParkinsonsApp
////
////  Created by Andreas on 5/7/21.
////
//
//import SwiftUI
//
//struct MedsRow: View {
//    @Binding var med: UserData
//    @State var open: Bool = false
////    @Binding var week: Week
////    @Binding var days: [Day]
//    @State var created = false
//    var body: some View {
//        HStack {
//            VStack {
//                HStack {
//                    Text(med.title)
//                .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
//                    Spacer()
//                }
//                HStack {
//                    Text(String(med.goal) + " " + med.unit)
//                    .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
//                    Spacer()
//            }
//            }
//            Button(action: {
//                med.amountTaken += med.amountNeeded
//                created = true
//            }) {
//                Image(systemName: "plus")
//                    .font(.largeTitle)
//                    .foregroundColor(.white)
//                    .padding()
//                    .padding()
//                    .background(Circle().foregroundColor(Color("teal")).padding())
//            }
//            Spacer()
//            Button(action: {
//                open = true
//            }) {
//                Image(systemName: "arrow.right")
//                    .font(.title)
//            }
//        } .padding()
//        .sheet(isPresented: $open, content: {
//            //MedsDetailsView(med: $med)
//        })
//        .sheet(isPresented: $created, content: {
//            ZStack {
//            VStack {
//                DismissSheetBtn()
//                Spacer()
//                Text("Added \(med.amountNeeded.removeZerosFromEnd()) \(med.unit) of \(med.name)")
//                .font(.custom("Poppins-Bold", size: 24, relativeTo: .headline))
//
//                Spacer()
//            }
//                ForEach(0 ..< 20) { number in
//                                    ConfettiView()
//                                    }
//            }
//        })
//    }
//}
