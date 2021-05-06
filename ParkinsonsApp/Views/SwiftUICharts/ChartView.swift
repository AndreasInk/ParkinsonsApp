//
//  ChartView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI
struct WeekChartView: View {
    
    @Binding var week: Week
    @State var chartData = ChartData(values: [("", 0.0)])
    @State var refresh = false
    var body: some View {
        ZStack {
            Color.clear
                .onAppear() {
                    chartData = ChartData(values: [(week.mon.totalScore == 21.0 ? "NA" : "Monday", (week.mon.totalScore ) == 21.0 ? 0.0 : week.mon.totalScore ), (week.tue.totalScore == 21.0 ? "NA" : "Tuesday", (week.tue.totalScore ) == 21.0 ? 0.0 : week.tue.totalScore ), (week.wed.totalScore == 21.0 ? "NA" : "Wednesday", (week.wed.totalScore ) == 21.0 ? 0.0 : week.wed.totalScore ), (week.thur.totalScore == 21.0 ? "NA" : "Thursday", (week.thur.totalScore ) == 21.0 ? 0.0 : week.thur.totalScore ), (week.fri.totalScore == 21.0 ? "NA" : "Friday", (week.fri.totalScore ) == 21.0 ? 0.0 : week.fri.totalScore ), (week.sat.totalScore == 21.0 ? "NA" : "Saturday", (week.sat.totalScore ) == 21.0 ? 0.0 : week.sat.totalScore ), (week.sun.totalScore == 21.0 ? "NA" : "Sunday", (week.sun.totalScore ) == 21.0 ? 0.0 : week.sun.totalScore )])
                }
            BarChartView(data: $chartData, title: "Score", legend: "", refresh: $refresh)
            
        }
    }
}
struct HabitWeekChartView: View {
    
    @Binding var week: Week
    @State var chartData = ChartData(values: [("", 0.0)])
    
    @State var refresh = false
    var body: some View {
        ZStack {
            Color.clear
                .onAppear() {
                    
                    chartData = ChartData(values: [( "Monday", Double(week.mon.habit.count)), ("Tuesday", Double(week.tue.habit.count)), ("Wednesday", Double(week.wed.habit.count))])
                    
                    chartData.points.append(("Thursday", Double(week.thur.habit.count)))
                    chartData.points.append(("Friday", Double(week.fri.habit.count)))
                    chartData.points.append(("Saturday", Double(week.sat.habit.count)))
                    chartData.points.append(("Sunday", Double(week.sun.habit.count)))
                }
            BarChartView(data: $chartData, title: "Score", legend: "", refresh: $refresh)
            
        }
    }
}
struct DayChartView: View {
    @State var title: String
    @Binding var chartData: ChartData
    @State var refresh: Bool = false
    var body: some View {
        return  BarChartView(data: $chartData , title: title, legend: "", refresh: $refresh)
    }
}

