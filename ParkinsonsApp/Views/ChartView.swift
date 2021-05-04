//
//  ChartView.swift
//  ParkinsonsApp
//
//  Created by Andreas on 5/4/21.
//

import SwiftUI
import Charts
struct ChartView: View {
    @State var weekdays = ["Mon", "Tues", "Wed", "Thur", "Fri", "Sat", "Sun"]
    var body: some View {
        VStack {
            HStack {
            Text("Overall Score")
                .font(.custom("Poppins-Bold", size: 16, relativeTo: .subheadline))
                Spacer()
            } .padding()
        Chart(data: [0.1, 0.3, 0.2, 0.5, 0.4, 0.9, 0.1])
            .chartStyle(
                ColumnChartStyle(column: Capsule().foregroundColor(Color("teal")), spacing: 2)
            )
            .padding()
            HStack {
                Spacer()
                ForEach(weekdays, id: \.self) { day in
                    Text(day)
                        .font(.custom("Poppins-Bold", size: 10, relativeTo: .subheadline))
                        .frame(width: 25)
                    Spacer()
                }
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
