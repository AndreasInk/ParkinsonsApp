//
//  MedsView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/7/21.
//
//
//import SwiftUI
//
//struct MedsView: View {
//    @Binding var userData: [UserData]
//    @State var meds = [UserData]()
//    @Binding var tutorialNum: Int
//    @Binding var isTutorial: Bool
//    @State var add = false
//    @Environment(\.presentationMode) var presentationMode
//    var body: some View {
//        ZStack {
//            Color.clear
//                .onAppear() {
//                    var medications = userData.filter { data in
//                        return  data.type == .Meds
//                    }
//                   
//                }
//        VStack {
//            if isTutorial {
//                VStack {
//                   
//                    Text("Tap the add symbol after the tutorial to add medications and set medication notifications.")
//                    .fixedSize(horizontal: false, vertical: true)
//                    .multilineTextAlignment(.center)
//                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
//                        .padding()
//                    
//                    Button(action: {
//                    tutorialNum += 1
//                    presentationMode.wrappedValue.dismiss()
//                    }) {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 25.0)
//                                .foregroundColor(Color(.lightGray))
//                                .frame(height: 75)
//                                .padding()
//                            Text("Next")
//                                .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
//                                .foregroundColor(.white)
//                        }
//                    } .buttonStyle(CTAButtonStyle())
//            }
//            }
//            HStack {
//                if !isTutorial {
//                    DismissSheetBtn()
//                }
//                Spacer()
//                Button(action: {
//                    add = true
//                }) {
//                    Image(systemName: "plus")
//                        .padding()
//                        .font(.title)
//                        .foregroundColor(Color("blue"))
//                }
//                .sheet(isPresented: $add, content: {
//                   // CreateMedView(meds: $meds, add: $add)
//                })
//               
//                
//            }
//            if meds.isEmpty {
//                Spacer()
//                Image("water")
//                    .resizable()
//                    .scaledToFit()
//                    .padding()
//                Button(action: {
//                add = true
//                }) {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 25.0)
//                            .foregroundColor(Color("teal"))
//                            .frame(height: 75)
//                            .padding()
//                        Text("Add a Med")
//                            .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
//                            .foregroundColor(.white)
//                    }
//                } .buttonStyle(CTAButtonStyle())
//            } else {
//        ForEach(meds.indices, id: \.self) { i in
//            //MedsRow(med: $meds[i], userData: $userData)
//                
//        }
//        }
//            Spacer()
//                .onChange(of: meds, perform: { value in
//                    for i in meds.indices {
//                        print(i)
//                    let today = meds[i].date.get(.weekday)
//                        print(meds[i])
//                    print(today)
//                        if today == 2 {
//                            week.mon.meds.append(Med(id: UUID(), name: meds[i].name, notes: meds[i].notes, amountNeeded: meds[i].amountNeeded, amountTaken: meds[i].amountTaken, unit: meds[i].unit, date: meds[i].date, date1: meds[i].date1, date2: meds[i].date2, date3: meds[i].date3))
//                        } else if today == 3 {
//                            
//                            week.tue.meds.append(Med(id: UUID(), name: meds[i].name, notes: meds[i].notes, amountNeeded: meds[i].amountNeeded, amountTaken: meds[i].amountTaken, unit: meds[i].unit, date: meds[i].date, date1: meds[i].date1, date2: meds[i].date2, date3: meds[i].date3))
//                            
//                        } else if today == 4 {
//                            week.wed.meds.append(Med(id: UUID(), name: meds[i].name, notes: meds[i].notes, amountNeeded: meds[i].amountNeeded, amountTaken: meds[i].amountTaken, unit: meds[i].unit, date: meds[i].date, date1: meds[i].date1, date2: meds[i].date2, date3: meds[i].date3))
//                        } else if today == 5 {
//                            week.thur.meds.append(Med(id: UUID(), name: meds[i].name, notes: meds[i].notes, amountNeeded: meds[i].amountNeeded, amountTaken: meds[i].amountTaken, unit: meds[i].unit, date: meds[i].date, date1: meds[i].date1, date2: meds[i].date2, date3: meds[i].date3))
//                        }  else if today == 6 {
//                            week.fri.meds.append(Med(id: UUID(), name: meds[i].name, notes: meds[i].notes, amountNeeded: meds[i].amountNeeded, amountTaken: meds[i].amountTaken, unit: meds[i].unit, date: meds[i].date, date1: meds[i].date1, date2: meds[i].date2, date3: meds[i].date3))
//                            print(12232223)
//                        }  else if today == 7 {
//                            week.sat.meds.append(Med(id: UUID(), name: meds[i].name, notes: meds[i].notes, amountNeeded: meds[i].amountNeeded, amountTaken: meds[i].amountTaken, unit: meds[i].unit, date: meds[i].date, date1: meds[i].date1, date2: meds[i].date2, date3: meds[i].date3))
//                            print(12232223)
//                        } else if today == 1 {
//                            week.sun.meds.append(Med(id: UUID(), name: meds[i].name, notes: meds[i].notes, amountNeeded: meds[i].amountNeeded, amountTaken: meds[i].amountTaken, unit: meds[i].unit, date: meds[i].date,date1: meds[i].date1, date2: meds[i].date2, date3: meds[i].date3))
//                        
//                        }
//                    let encoder = JSONEncoder()
//                    meds = meds.removeDuplicates()
//                    if let encoded = try? encoder.encode(meds.removeDuplicates()) {
//                        if let json = String(data: encoded, encoding: .utf8) {
//                            
//                            do {
//                                let url = self.getDocumentsDirectory().appendingPathComponent("meds.txt")
//                                try json.write(to: url, atomically: false, encoding: String.Encoding.utf8)
//                                
//                            } catch {
//                                print("erorr")
//                            }
//                        }
//                        
//                    }
//                        if days.indices.contains(6) {
//                        days.removeLast(6)
//                        }
//                        days.append(week.mon)
//                        days.append(week.tue)
//                        days.append(week.wed)
//                        days.append(week.thur)
//                        days.append(week.fri)
//                        days.append(week.sat)
//                        days.append(week.sun)
//                    }
//                })
//                
//        }
//        }
//        
//    }
//    func getDocumentsDirectory() -> URL {
//        // find all possible documents directories for this user
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        
//        // just send back the first one, which ought to be the only one
//        return paths[0]
//    }
//}
