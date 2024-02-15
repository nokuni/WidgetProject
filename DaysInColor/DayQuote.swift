//
//  DayQuote.swift
//  WidgetProject
//
//  Created by Yann Christophe Maertens on 22/11/2023.
//

import SwiftUI

class DayQuoteViewModel: ObservableObject {
    
    init() {
        quotes = try! bundleManager.decodeJSON("quotes.json")
    }
    
    let bundleManager = BundleManager()
    
    var quotes = [Quote]()
    
    var currentDay: String? {
        Date().dayOfWeek()
    }
    
    var currentDayNumber: Int? {
        Date().dayNumberOfWeek()
    }
    
    var currentColor: Color {
        guard let currentDayNumber else { return .clear }
        switch currentDayNumber {
        case 1: return .red
        case 2: return .yellow
        case 3: return .pink
        case 4: return .green
        case 5: return .orange
        case 6: return .blue
        case 7: return .purple
        default: return .clear
        }
    }
    
    var currentQuote: Quote? {
        guard let currentDayNumber, currentDayNumber < quotes.count else { return nil }
        return quotes[currentDayNumber]
    }
}

struct Quote: Codable {
    var quote: String
    var author: String
}

struct DayQuote {
    var day: String
    var quote: Quote
    var color: Color
}

