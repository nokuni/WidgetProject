//
//  DaysInColorLiveActivity.swift
//  DaysInColor
//
//  Created by Yann Christophe Maertens on 22/11/2023.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DaysInColorAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DaysInColorLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DaysInColorAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension DaysInColorAttributes {
    fileprivate static var preview: DaysInColorAttributes {
        DaysInColorAttributes(name: "World")
    }
}

extension DaysInColorAttributes.ContentState {
    fileprivate static var smiley: DaysInColorAttributes.ContentState {
        DaysInColorAttributes.ContentState(emoji: "Hello")
     }
     
     fileprivate static var starEyes: DaysInColorAttributes.ContentState {
         DaysInColorAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: DaysInColorAttributes.preview) {
   DaysInColorLiveActivity()
} contentStates: {
    DaysInColorAttributes.ContentState.smiley
    DaysInColorAttributes.ContentState.starEyes
}
