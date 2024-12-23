//
//  Birdspot.swift
//  Backyard Birdies
//
//  Created by dmu mac 31 on 09/12/2024.
//

import Foundation
import CoreLocation
import FirebaseFirestore

struct Birdspot: Identifiable, Codable {
    @DocumentID var id: String?
    let date: Date
    let location: GeoPoint
    let note: String
    let species: Species
    let image: Data
    
}

enum Species: String, Codable, CaseIterable {
    case fletchling = "Fletchling",
    murkrow = "Murkrow", pidgoet = "Pidgoet", pidgey = "Pidgey", talonflame = "Talonflame",
    ducklett = "Ducklett", cramorant = "Cramorant", articuno = "Articuno", chatot = "Chatot",
    vullaby = "Vullaby", pikipek = "Pikipek", pidove = "Pidove", tranquil = "Tranquil", dotrio = "Dotrio",
    hooh = "Ho'oh", starly = "Starly", spearow = "Spearow", doduo = "Doduo", natu = "Natu",
    altaria = "Altaria", braviary = "Braviary"
}
