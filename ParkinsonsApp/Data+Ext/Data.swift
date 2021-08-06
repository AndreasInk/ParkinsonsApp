//
//  Data.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI


//struct UserData: Identifiable, Codable, Hashable {
//    var id: String
//    var type: DataType
//    var title: String
//    var date: Date
//    var data: Double
//    var goal: Double
//    var unit: String?
//
//}
enum DataType: String, Codable, CaseIterable {
    case Tremor = "Tremor"
    case Balance = "Balance"
    case WalkingSpeed = "WalkingSpeed"
    case Stride = "Stride"
    case Asymmetry = "Asymmetry"
    case Habit = "Habit"
    case Meds = "Meds"
    case Score = "Score"
    case HappinessScore = "HappinessScore"
    case Health = "Health"

//    case TremorPredicted = "TremorPredicted"
//    case BalancePredicted = "BalancePredicted"
//    case WalkingSpeedPredicted = "WalkingSpeedPredicted"
//    case StridePredicted = "StridePredicted"
//    case AsymmetryPredicted = "AsymmetryPredicted"
//    case HabitPredicted = "HabitPredicted"
//    case ScorePredicted = "ScorePredicted"
//    case HappinessScorePredicted = "HappinessScorePredicted"
}

enum DateDistanceType: String, Codable, CaseIterable {
    case Week = "Week"
    case Month = "Month"
    
}


//enum DataType: String, Codable, CaseIterable {
//    case StepLength = "StepLength"
//    case Health = "Health"
//    case EmotionTagging = "EmotionTagging"
//    case Heartrate = "Heartrate"
//    case PhoneUsage = "PhoneUsage"
//    case Habit = "Habit"
//    case Meds = "Meds"
//    case Food = "Food"
//    case HappinessScore = "HappinessScore"
//    case Score = "Score"
//    
//}



struct UserData: Identifiable, Codable, Hashable {
    var id: String
    var type: DataType
    var title: String
    var text: String
    var date: Date
    var data: Double

    
    
}
struct Habit:  Identifiable, Codable, Hashable {
    var id: String
    var data: [UserData]
    var title: String
}

struct ModelResponse: Codable {
    var type: String
    var predicted: [Double]
    var actual: [Double]
    var accuracy: Double
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

