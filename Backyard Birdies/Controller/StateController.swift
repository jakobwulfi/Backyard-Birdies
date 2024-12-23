//
//  StateController.swift
//  Backyard Birdies
//
//  Created by dmu mac 31 on 09/12/2024.
//

import SwiftUI

@Observable
class StateController {
    var quote: Quote?
    let defaults = UserDefaults.standard
    private var lastQuoteID: Int?

    func saveQuoteID(id: Int) {
        defaults.set(id, forKey: "lastQuoteID")
        lastQuoteID = defaults.value(forKey: "lastQuoteID") as? Int
    }
        
    init() {
        guard let randomQuoteURL = URL(string: "https://dummyjson.com/quotes/random") else {return}
        lastQuoteID = defaults.value(forKey: "lastQuoteID") as? Int ?? 000
        fetchQuote(from: randomQuoteURL)
    }
    
    private func fetchQuote(from url: URL) {
        Task(priority: .medium) {
            var found = false
            var jsonResult: Quote? = nil
            let decoder = JSONDecoder()
            
            while !found {
                guard let rawQuoteData = await NetworkService.getData(from: url) else { return }
                do {
                    let decodedQuote = try decoder.decode(Quote.self, from: rawQuoteData)
                    if decodedQuote.id != lastQuoteID {
                        found = true
                        jsonResult = decodedQuote
                        saveQuoteID(id: decodedQuote.id)
                    } else {
                        print("Duplicate quote detected, retrying...")
                    }
                } catch {
                    print("Failed to decode quote, retrying...")
                }
            }
            if let validQuote = jsonResult {
                Task { @MainActor in
                    self.quote = validQuote
                }
            }
        }
    }
}
