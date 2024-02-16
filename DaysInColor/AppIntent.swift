//
//  AppIntent.swift
//  DaysInColor
//
//  Created by Yann Christophe Maertens on 22/11/2023.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "Hello")
    var favoriteEmoji: String
}
