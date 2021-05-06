//
//  WidgetView.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import SwiftUI
import WidgetKit

struct ConfigureWidgetView: View {
    @State var color1 = Color("blue")
    @State var color2 = Color("lightBlue")
    @State var textColor = Color(.white)
    @State var course = "Expirations"
    @State var font = "Poppins-Bold"
    var body: some View {
        ZStack {
            Color.clear
                .onAppear() {
                    let defaults = UserDefaults(suiteName: "group.parkinsonsappv2.app")
                    color1 =  Color(defaults?.colorForKey(key: "color1") ?? UIColor(named: "blue")!)
                    color2 = Color(defaults?.colorForKey(key: "color2") ?? UIColor(named: "teal")!)
                }
            ScrollView(showsIndicators: false) {
        VStack {
            WidgetPreview(color1: $color1, color2: $color2, textColor: $textColor, course: $course, font: $font)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .rotation3DEffect(.degrees(3), axis: (x: 0, y: 1, z: 0))
                .shadow(radius: 35)
                
                .padding(.vertical, 100)
//            ClassSelectionView(color1: $color1, color2: $color2, textColor: $textColor, course: $course)
//                .onChange(of: course, perform: { value in
//                    let defaults = UserDefaults(suiteName: "group.gradebook.app")
//                    defaults?.setValue(course, forKey: "course")
//                    WidgetCenter.shared.reloadAllTimelines()
//                })
            ColorPicker("Background Color 1", selection: $color1)
                .font(.custom("Poppins", size: 16, relativeTo: .subheadline))
                .padding()
                .onChange(of: color1, perform: { value in
                    let defaults = UserDefaults(suiteName: "group.parkinsonsappv2.app")
                    defaults?.setColor(color: UIColor(color1), forKey: "color1")
                    WidgetCenter.shared.reloadAllTimelines()
                })
            ColorPicker("Background Color 2", selection: $color2)
                .font(.custom("Poppins", size: 16, relativeTo: .subheadline))
                .padding()
                .onChange(of: color2, perform: { value in
                    let defaults = UserDefaults(suiteName: "group.parkinsonsappv2.app")
                    defaults?.setColor(color: UIColor(color2), forKey: "color2")
                    WidgetCenter.shared.reloadAllTimelines()
                })
            ColorPicker("Text Color", selection: $textColor)
                .font(.custom("Poppins", size: 16, relativeTo: .subheadline))
                .padding()
                .onChange(of: textColor, perform: { value in
                    let defaults = UserDefaults(suiteName: "group.parkinsonsappv2.app")
                    defaults?.setColor(color: UIColor(textColor), forKey: "textColor")
                    WidgetCenter.shared.reloadAllTimelines()
                })
            FontSelectionView(color1: $color1, color2: $color2, textColor: $textColor, font: $font)
                .onChange(of: font, perform: { value in
                    let defaults = UserDefaults(suiteName: "group.parkinsonsappv2.app")
                    defaults?.setValue(font, forKey: "font")
                    WidgetCenter.shared.reloadAllTimelines()
                })
          Spacer()
        }
    }
    }
    }
}


