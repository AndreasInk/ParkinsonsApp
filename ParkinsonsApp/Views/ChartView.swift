//
//  ChartView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI
import Charts
struct WeekChartView: View {
  
    @Binding var week: Week
    var body: some View {
        return  BarChartView(data: ChartData(values: [(week.mon.totalScore == 21.0 ? "NA" : "Monday", (week.mon.totalScore ?? 0.0) == 21.0 ? 0.0 : week.mon.totalScore ?? 0.01), (week.tue.totalScore == 21.0 ? "NA" : "Tuesday", (week.tue.totalScore ?? 0.0) == 21.0 ? 0.0 : week.tue.totalScore ?? 0.01), (week.wed.totalScore == 21.0 ? "NA" : "Wednesday", (week.wed.totalScore ?? 0.0) == 21.0 ? 0.0 : week.wed.totalScore ?? 0.01), (week.thur.totalScore == 21.0 ? "NA" : "Thursday", (week.thur.totalScore ?? 0.0) == 21.0 ? 0.0 : week.thur.totalScore ?? 0.01), (week.fri.totalScore == 21.0 ? "NA" : "Friday", (week.fri.totalScore ?? 0.0) == 21.0 ? 0.0 : week.fri.totalScore ?? 0.01), (week.sat.totalScore == 21.0 ? "NA" : "Saturday", (week.sat.totalScore ?? 0.0) == 21.0 ? 0.0 : week.sat.totalScore ?? 0.01), (week.sun.totalScore == 21.0 ? "NA" : "Sunday", (week.sun.totalScore ?? 0.0) == 21.0 ? 0.0 : week.sun.totalScore ?? 0.01)])  , title: "Stride Progress", legend: "")
    }
}

struct DayChartView: View {
    @State var title: String
    @Binding var chartData: ChartData
    var body: some View {
        return  BarChartView(data: chartData , title: title, legend: "")
    }
}

