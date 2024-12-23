//
//  BirdspotController.swift
//  Backyard Birdies
//
//  Created by dmu mac 31 on 09/12/2024.
//

import SwiftUI

@Observable
class BirdspotController {
    var birdspots = [Birdspot]()
    
    @ObservationIgnored
    private var firebaseService = FirebaseService()
    
    init() {
        firebaseService.setUpListener { fetchedBirdspots in
            self.birdspots = fetchedBirdspots
        }
    }
    
    func add(birdspot: Birdspot) {
        firebaseService.addBirdspot(birdspot: birdspot)
    }
    
    func getBirdspots() -> [Birdspot] {
        var foundBirdspots: [Birdspot] = []
        Task(priority: .high) {
            foundBirdspots = await firebaseService.getSortedBirdspots()
        }
        return foundBirdspots
    }
}
