//
//  DayQuote.swift
//  WidgetProject
//
//  Created by Yann Christophe Maertens on 22/11/2023.
//

import SwiftUI
import Utility_Toolbox

class DayQuoteViewModel: ObservableObject {
    
    init() {
        do {
            quotes = try bundleManager.decodeJSON("quotes", fileExtension: "json")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    let bundleManager = BundleManager()
    
    #warning("ERROR: We can't connect to the server for this app or website at this time. There might be too much traffic or a configuration error. Try again later, or contact the app or website owner")
    let header = "X-Api-Key"
    let key = "GzYkCyqhvJhHRNvZCCf1zg==nRk95G5p5th91igW"
    let url = "https://api.api-ninjas.com/v1/quotes?category=happiness"
    let apiManager = APIManager()
    
    var quotes = [Quote]()
    
    var days: [String] {
        ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    }
    
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

//struct Quote: Codable, Hashable {
//    var quote: String
//    var author: String
//    var category: String
//}

struct Quote: Codable, Hashable {
    var quote: String
    var author: String
}

struct DayQuote: Hashable {
    var day: String
    var quote: Quote
    var color: Color
}
