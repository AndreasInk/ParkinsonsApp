//
//  Data.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI


struct UserData: Identifiable, Codable, Hashable {
    var id: String
    var type: DataType
    var title: String?
    var date: Date
    var data: Double
    
    
}
enum DataType: String, Codable {
    case Tremor = "Tremor"
    case Balance = "Balance"
    case WalkingSpeed = "WalkingSpeed"
    case Stride = "Stride"
    case Asymmetry = "Asymmetry"
    case Habit = "Habit"
    case Score = "Score"
}

//struct Tremor: Identifiable, Codable, Hashable{
//    var id: String
//    var severity: Double
//    var date: Date
//
//
//}
//struct Balance: Identifiable, Codable, Hashable{
//    var id: String
//    var value: Double
//    var date: Date
//
//
//}
//struct WalkingSpeed: Identifiable, Codable, Hashable{
//    var id: String
//    var speed: Double
//    var date: Date
//
//
//}
//
//struct Stride: Identifiable, Codable, Hashable{
//    var id: String
//    var length: Double
//    var date: Date
//
//
//}
//
//struct Asymmetry: Identifiable, Codable, Hashable{
//    var id: String
//    var asym: Double
//    var date: Date
//
//
//}
//struct Week: Identifiable, Codable, Hashable {
//    var id: String
//    var sun: Day
//    var mon: Day
//    var tue: Day
//    var wed: Day
//    var thur: Day
//    var fri: Day
//    var sat: Day
//}

//struct Day: Identifiable, Codable, Hashable {
//    var id: String
//    var score: [Score]
//    var tremor: [Tremor]
//    var balance: [Balance]
//    var walkingSpeed: [WalkingSpeed]
//    var strideLength: [Stride]
//    var aysm: [Asymmetry]
//    var habit: [Habit]
//    var date: Date
//    var totalScore: Double
//    var meds: [Med]
//
//}

struct PredictedScore: Codable, Hashable {
    var prediction: Double
    var predicted_parkinsons: Int
    var date: Date
}


struct GridButton {
    var title: String
    var image: Image
}


struct Setting: Codable, Hashable {
    var title: String
    var text: String
    var onOff: Bool
    var dates: [Int]?
    var cta: String?
}


struct Onboarding: Identifiable, Hashable {
    var id: UUID
    var image: String
    var title: String
    var description: String
}

struct Med: Identifiable, Hashable, Codable {
    var id: UUID
    var name: String
    var notes: String
    var amountNeeded: Double
    var amountTaken: Double
    var unit: String
    var date: Date
    var date1: Int
    var date2: Int
    var date3: Int
}

