//
//  DetailView.swift
//  Backyard Birdies
//
//  Created by dmu mac 31 on 09/12/2024.
//

import SwiftUI
import MapKit

struct ListView: View {
    @Environment(BirdspotController.self) private var birdspotController
    @State private var isSortedBySpecies = false
    
    var body: some View {
        NavigationStack {
            Toggle("Sort by species", isOn: $isSortedBySpecies)
                .padding()
            List {
                if (birdspotController.birdspots.isEmpty) {
                    ProgressView("List is loading")
                } else if (isSortedBySpecies == false) {
                    ForEach(birdspotController.birdspots) { birdspot in
                        NavigationLink(destination: DetailView(birdspot: birdspot)) {
                            Text("\(birdspot.species.rawValue), \(birdspot.date.formatted())")
                        }
                    }
                } else {
                    ForEach(birdspotController.birdspots.sorted {
                        $0.species.rawValue < $1.species.rawValue}
                    ) { birdspot in
                        NavigationLink(destination: DetailView(birdspot: birdspot)) {
                            Text("\(birdspot.species.rawValue), \(birdspot.date.formatted())")
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .status) {
                    NavigationLink(destination: AddBirdspotView()) {
                        Text("Add Birdspotting")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
            .navigationTitle("Bird Spots")
            .navigationBarBackButtonHidden(true)
        }
    }
}


    


#Preview {
    ListView().environment(BirdspotController())
}
