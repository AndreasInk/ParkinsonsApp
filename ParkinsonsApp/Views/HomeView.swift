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
    let model = reg_model()
    @Binding var week: Week
    @Binding var days: [Day]
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding()
                Spacer()
                    .onAppear() {
                        do {
                            let double = week.mon.balance.map({ $0.value })
                            
                            let speed = week.mon.walkingSpeed.map({ $0.speed })
                            let length = week.mon.strideLength.map({ $0.length })
                            let aysm = week.mon.aysm.map({ $0.asym })
                            
                           
                            getLocalScore(double: average(numbers: double), speed: average(numbers: speed), length: average(numbers: length)) { (score) in
                                week.mon.totalScore = score.prediction
                                if week.mon.balance.last?.date.get(.day) ?? 0 == Date().get(.day) {
                                   // progressValue = score.prediction
                                }
                            }
                         
                        } catch {
                            // something went wrong!
                        }
                        do {
                            let double = week.tue.balance.map({ $0.value })
                            let speed = week.tue.walkingSpeed.map({ $0.speed })
                            let length = week.tue.strideLength.map({ $0.length })
                            let aysm = week.tue.aysm.map({ $0.asym })
                           
                           
                            getLocalScore(double: average(numbers: double), speed: average(numbers: speed), length: average(numbers: length)) { (score) in
                                week.tue.totalScore = score.prediction
                                if week.tue.balance.last?.date.get(.day) ?? 0 == Date().get(.day) {
                                   // progressValue = score.prediction
                                }
                            }
                            
                          
                        } catch {
                            // something went wrong!
                        }
                        do {
                            let double = week.wed.balance.map({ $0.value })
                            let speed = week.wed.walkingSpeed.map({ $0.speed })
                            let length = week.wed.strideLength.map({ $0.length })
                            let aysm = week.wed.aysm.map({ $0.asym })
                            
                            

                            getLocalScore(double: average(numbers: double), speed: average(numbers: speed), length: average(numbers: length)) { (score) in
                                week.wed.totalScore = score.prediction
                                if week.wed.balance.last?.date.get(.day) ?? 0 == Date().get(.day) {
                                    //progressValue = score.prediction
                                }
                            }
                           
                            
                          
                        } catch {
                            // something went wrong!
                        }
                        do {
                            let double = week.thur.balance.map({ $0.value })
                            let speed = week.thur.walkingSpeed.map({ $0.speed })
                            let length = week.thur.strideLength.map({ $0.length })
                            let aysm = week.thur.aysm.map({ $0.asym })
                          
                            
                            getLocalScore(double: average(numbers: double), speed: average(numbers: speed), length: average(numbers: length)) { (score) in
                                week.thur.totalScore = score.prediction
                                if week.thur.balance.last?.date.get(.day) ?? 0 == Date().get(.day) {
                                   // progressValue = score.prediction
                                }
                            }
                         
                        } catch {
                            // something went wrong!
                        }
                        do {
                            let double = week.fri.balance.map({ $0.value })
                            let speed = week.fri.walkingSpeed.map({ $0.speed })
                            let length = week.fri.strideLength.map({ $0.length })
                            let aysm = week.fri.aysm.map({ $0.asym })
                            
                            
                            getLocalScore(double: average(numbers: double), speed: average(numbers: speed), length: average(numbers: length)) { (score) in
                                week.fri.totalScore = score.prediction
                                if week.fri.balance.last?.date.get(.day) ?? 0 == Date().get(.day) {
                                   // progressValue = score.prediction
                                }
                            }
                          
                        } catch {
                            // something went wrong!
                        }
                        do {
                            let double = week.sat.balance.map({ $0.value })
                            let speed = week.sat.walkingSpeed.map({ $0.speed })
                            let length = week.sat.strideLength.map({ $0.length })
                            let aysm = week.sat.aysm.map({ $0.asym })
                           
                           
                            getLocalScore(double: average(numbers: double), speed: average(numbers: speed), length: average(numbers: length)) { (score) in
                                week.sat.totalScore = score.prediction
                                if week.sat.balance.last?.date.get(.day) ?? 0 == Date().get(.day) {
                                  //  progressValue = score.prediction
                                }
                            }
                            
                          
                        } catch {
                            // something went wrong!
                        }
                        do {
                            let double = week.sun.balance.map({ $0.value })
                            let speed = week.sun.walkingSpeed.map({ $0.speed })
                            let length = week.sun.strideLength.map({ $0.length })
                            let aysm = week.sun.aysm.map({ $0.asym })
                           
                        
                           
                            getLocalScore(double: average(numbers: double), speed: average(numbers: speed), length: average(numbers: length)) { (score) in
                                week.sun.totalScore = score.prediction
                                if week.sun.balance.last?.date.get(.day) ?? 0 == Date().get(.day) {
                                   // progressValue = score.prediction
                                }
                            }
                           
                            
                        } catch {
                            // something went wrong!
                        }
                        
                        
                    }
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
            .onAppear() {
                days.append(week.mon)
                days.append(week.tue)
                days.append(week.wed)
                days.append(week.thur)
                days.append(week.fri)
                days.append(week.sat)
                days.append(week.sun)
            }
            //CardView()
            ButtonGridView(days: $days)
            WeekChartView(week: $week)
                .padding(.bottom)
        }
    }
    func getLocalScore(double: Double, speed: Double, length: Double, completionHandler: @escaping (PredictedScore) -> Void) {
        if double.isNormal {
        do {
            let prediction =  try self.model.prediction(double_: double, speed: speed, length: length)
            completionHandler(PredictedScore(prediction: prediction.sourceName, predicted_parkinsons: prediction.sourceName > 0.5 ? 1 : 0))
        } catch {

        }
        } else {
            completionHandler(PredictedScore(prediction: 21.0, predicted_parkinsons: 21))
        }
    }
    
func average(numbers: [Double]) -> Double {
   // print(numbers)
    return Double(numbers.reduce(0,+))/Double(numbers.count)
}
}

