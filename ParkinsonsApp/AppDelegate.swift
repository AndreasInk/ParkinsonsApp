//
//  AppDelegate.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import UIKit
import Firebase
import HealthKit
import WidgetKit
import CoreML
import NiceNotifications
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var userData = [UserData]()
    
    private var useCount = UserDefaults.standard.integer(forKey: "useCount")
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
     
       

            
        return true
    }

    func average(numbers: [Double]) -> Double {
        // print(numbers)
        return Double(numbers.reduce(0,+))/Double(numbers.count)
    }
    
}

