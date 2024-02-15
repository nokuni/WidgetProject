//
//  ContentView.swift
//  WidgetProject
//
//  Created by Yann Christophe Maertens on 22/11/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dayQuote = DayQuoteViewModel()
    var body: some View {
        List(dayQuote.quotes.indices, id: \.self) { index in
            VStack(alignment: .leading) {
                Text(dayQuote.days[index])
                    .fontWeight(.bold)
                    .font(.title3)
                Text(dayQuote.quotes[index].quote)
                Text(dayQuote.quotes[index].author)
                    .italic()
            }
        }
    }
}

#Preview {
    ContentView()
}
