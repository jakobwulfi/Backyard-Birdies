//
//  Quotes.swift
//  Backyard Birdies
//
//  Created by dmu mac 31 on 09/12/2024.
//

import Foundation

struct Quote: Decodable {
    let id: Int
    let quote: String
    let author: String
}
