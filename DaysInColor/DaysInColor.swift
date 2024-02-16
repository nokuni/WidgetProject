//
//  DaysInColor.swift
//  DaysInColor
//
//  Created by Yann Christophe Maertens on 22/11/2023.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let entries: [SimpleEntry] = []
        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct DaysInColorEntryView : View {
    @ObservedObject var dayQuote: DayQuoteViewModel
    var body: some View {
        if let currentQuote = dayQuote.currentQuote {
            VStack(alignment: .leading, spacing: 15) {
                if let currentDay = dayQuote.currentDay {
                    Text(currentDay)
                        .fontWeight(.bold)
                        .font(.title2)
                        .foregroundStyle(.background)
                }
                Text(currentQuote.quote)
                    .foregroundStyle(.background)
                Text(currentQuote.author)
                    .italic()
                    .foregroundStyle(.background)
            }
        }
    }
}

struct DaysInColor: Widget {
    @StateObject var dayQuote = DayQuoteViewModel()
    let kind: String = "DaysInColor"
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            // I don't use the entry because the quotes are already configured by showwing a different one each day of the week
            DaysInColorEntryView(dayQuote: dayQuote)
                .containerBackground(dayQuote.currentColor, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    DaysInColor()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
