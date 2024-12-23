//
//  ContentView.swift
//  Backyard Birdies
//
//  Created by dmu mac 31 on 09/12/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(StateController.self) var stateController: StateController
    var body: some View {
        NavigationStack {
            VStack {
                QuoteView()
                NavigationLink(destination: ListView()) {
                    Text("Continue")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(StateController())
        .environment(BirdspotController())
}
