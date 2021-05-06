//
//  ParkinsonsWidgetv2.swift
//  ParkinsonsWidgetv2
//
//  Created by Andreas on 5/5/21.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}
struct smallWidgetView : View {
    var entry: Provider.Entry
    @State var color1 = UIColor(named: "blue")
    @State var color2 = UIColor(named: "teal")
    @State var textColor = UIColor(.white)
    @State var course = "Expirations"
    @State var font = "Poppins-Bold"
    @Environment(\.widgetFamily) var size
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var lastScore = UserDefaults(suiteName: "group.parkinsonsappv2.app")?.double(forKey: "lastScore")
    @State var averageScore = UserDefaults(suiteName: "group.parkinsonsappv2.app")?.double(forKey: "averageScore")
    @State var timeTillString = ""
    var body: some View {
        ZStack {
            
            Color.clear
                .onAppear() {
                    let defaults = UserDefaults(suiteName: "group.parkinsonsappv2.app")
                    color1 = defaults?.colorForKey(key: "color1") ?? color1
                    color2 = defaults?.colorForKey(key: "color2") ?? color2
                    textColor = defaults?.colorForKey(key: "textColor") ?? textColor
                    font = defaults?.string(forKey: "font") ?? font
                    course = defaults?.string(forKey: "course") ?? course
                    timeTillString = "\(defaults?.integer(forKey: "min") ?? 0) " + "days"
                }
                
           
            LinearGradient(gradient: Gradient(colors: [(Color(color1!)), (Color(color2!))]), startPoint: .leading, endPoint: .bottomTrailing)
                
                VStack {
                    HStack {
                    Text("Score")
                        .font(.custom(font, size: 18, relativeTo: .headline))
                        .foregroundColor((Color(textColor)))
                        Spacer()
                    }
                    HStack {
                        Text(String(lastScore ?? 0.0))
                        .font(.custom(font, size: 48, relativeTo: .title))
                        
                            .foregroundColor(Color(textColor.cgColor))
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        VStack {
                            HStack {
                        Text("Average")
                            .foregroundColor(Color(textColor))
                            .font(.custom(font, size: 16, relativeTo: .subheadline))
                                Spacer()
                            }
                            HStack {
                                Text(String(averageScore ?? 0.0))
                            .font(.custom(font, size: 16, relativeTo: .subheadline))
                            .foregroundColor(Color(textColor))
                            
                                Spacer()
                            }
                        }
                        Spacer()
                        Text(lastScore ?? 0.0 < 0.2 ? "🎉" : "⚠️")
                            .font(.custom(font, size: 16, relativeTo: .subheadline))
    //                        .foregroundColor((textColor))
                        
                    }
                } .padding()
                
            }
        }
    }

struct ParkinsonsWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        smallWidgetView(entry: entry)
    }
}

@main
struct ParkinsonsWidget: Widget {
    let kind: String = "ParkinsonsWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            ParkinsonsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct ParkinsonsWidget_Previews: PreviewProvider {
    static var previews: some View {
        ParkinsonsWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


extension UserDefaults {
 func colorForKey(key: String) -> UIColor? {
  var color: UIColor?
  if let colorData = data(forKey: key) {
   color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor
  }
  return color
 }

 func setColor(color: UIColor?, forKey key: String) {
  var colorData: NSData?
   if let color = color {
    colorData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData?
  }
  set(colorData, forKey: key)
 }

}
